import 'package:dio/dio.dart';
import '../models/agent_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AgentModel> loginAgent(String username, String password) async {
    try {
      final response = await dio.post(
        'http://192.168.100.99:8081/api/auth/mobile/agent/login',
        data: {
          "username": username,
          "password": password,
        },
      );

      print("DEBUG RESPONSE BODY: ${response.data}"); // AJOUTE CECI

      final data = response.data;

      // Vérification de sécurité
      if (data == null) {
        throw Exception("Le serveur a renvoyé une réponse vide");
      }

      if (data['success'] == true) {
        return AgentModel.fromJson(data['data']); // 'data' contient l'objet AgentDto
      } else {
        throw Exception(data['message'] ?? 'Erreur d\'authentification');
      }
    } on DioException catch (e) {
      print("ERREUR DIO: ${e.response?.data}"); // AJOUTE CECI
      String errorMessage = "Erreur de connexion au serveur";
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? "Identifiants incorrects";
      }
      throw Exception(errorMessage);
    }
  }
}