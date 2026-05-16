import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../auth/domain/entities/agent_entity.dart';
import '../../../auth/data/models/agent_model.dart';

class VoteFormProvider with ChangeNotifier {
  // ================= VOTES =================
  int _candidate1Votes = 0;
  int _candidate2Votes = 0;
  int _candidate3Votes = 0;
  int _candidate4Votes = 0;
  int _candidate5Votes = 0;
  int _nullVotes = 0;

  File? capturedPvFile;
  bool isSubmitting = false;

  // ================= GETTERS =================
  int get candidate1Votes => _candidate1Votes;
  int get candidate2Votes => _candidate2Votes;
  int get candidate3Votes => _candidate3Votes;
  int get candidate4Votes => _candidate4Votes;
  int get candidate5Votes => _candidate5Votes;
  int get nullVotes => _nullVotes;

  // ================= TOTAL =================
  int get totalVotes =>
      _candidate1Votes +
      _candidate2Votes +
      _candidate3Votes +
      _candidate4Votes +
      _candidate5Votes +
      _nullVotes;

  // ================= UPDATE METHODS =================
  void updateCandidate1(String value) {
    _candidate1Votes = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateCandidate2(String value) {
    _candidate2Votes = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateCandidate3(String value) {
    _candidate3Votes = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateCandidate4(String value) {
    _candidate4Votes = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateCandidate5(String value) {
    _candidate5Votes = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateNullVotes(String value) {
    _nullVotes = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void setCapturedImage(File file) {
    capturedPvFile = file;
    notifyListeners();
  }

  // ================= LOGIQUE DE HASHAGE =================
  String calculateJsonHash() {
    final data = {
      "c1": _candidate1Votes,
      "c2": _candidate2Votes,
      "c3": _candidate3Votes,
      "c4": _candidate4Votes,
      "c5": _candidate5Votes,
      "nuls": _nullVotes,
    };
    final bytes = utf8.encode(jsonEncode(data));
    return sha256.convert(bytes).toString();
  }

  Future<String> calculateImageHash(File file) async {
    final bytes = await file.readAsBytes();
    return sha256.convert(bytes).toString();
  }

  // ================= SOUMISSION FINALE =================
  Future<bool> submitResults(String bureauId, String agentUsername) async {
    if (capturedPvFile == null) return false;

    isSubmitting = true;
    notifyListeners();

    try {
      // 1. Préparation des données brutes
      final Map<String, dynamic> rawDataMap = {
        "c1": _candidate1Votes,
        "c2": _candidate2Votes,
        "c3": _candidate3Votes,
        "c4": _candidate4Votes,
        "c5": _candidate5Votes,
        "nuls": _nullVotes,
      };
      final String rawJsonString = jsonEncode(rawDataMap);

      // 2. Calcul des Hashes
      final jsonHash = calculateJsonHash();
      final imageHash = await calculateImageHash(capturedPvFile!);

      // 3. Conversion de l'image en Base64 pour le stockage en DB
      final List<int> imageBytes = await capturedPvFile!.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      final dio = Dio(BaseOptions(
        baseUrl: 'http://192.168.100.99:8081',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

      // 4. Payload complet correspondant au DTO Java
      final payload = {
        "bureauId": bureauId,
        "agentUsername": agentUsername,
        "totalVotants": totalVotes,
        "rawJsonData": rawJsonString,
        "imageBase64": base64Image,
        "hashJsonData": jsonHash,
        "hashImagePv": imageHash,
      };

      print("🚀 Envoi du PV complet au backend...");

      final response = await dio.post(
        '/api/votes/submit-pv',
        data: payload,
      );

      print("DEBUG SUBMIT RESPONSE: ${response.data}");

      if (response.data != null && response.data['success'] == true) {
        isSubmitting = false;
        notifyListeners();
        return true;
      } else {
        throw Exception(response.data?['message'] ?? "Erreur serveur");
      }
    } on DioException catch (e) {
      print("❌ ERREUR DIO SOUMISSION: ${e.response?.data ?? e.message}");
      isSubmitting = false;
      notifyListeners();
      return false;
    } catch (e) {
      print("❌ ERREUR SOUMISSION: $e");
      isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  // ================= RAFRAÎCHISSEMENT AGENT =================
  Future<AgentEntity?> getUpdatedAgent(String username) async {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.100.99:8081',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    try {
      final response = await dio.get('/api/auth/mobile/agent/$username');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data['success'] == true) {
          return AgentModel.fromJson(data['data']);
        }
      }
    } catch (e) {
      print("❌ ERREUR RÉCUPÉRATION AGENT: $e");
    }
    return null;
  }
}
