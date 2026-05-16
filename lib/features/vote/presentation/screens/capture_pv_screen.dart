import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CapturePvScreen extends StatefulWidget {
  const CapturePvScreen({super.key});

  @override
  State<CapturePvScreen> createState() => _CapturePvScreenState();
}

class _CapturePvScreenState extends State<CapturePvScreen> {
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isCapturing = false;

  // ================= CAPTURE IMAGE =================
  Future<void> _captureImage() async {
    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _capturedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("Error capturing image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'accès à la caméra')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  // ================= RESET IMAGE =================
  void _resetImage() {
    if (_capturedImage == null) return;
    
    setState(() {
      _capturedImage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Capture réinitialisée'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  // ================= VALIDATE IMAGE =================
  void _validateImage() {
    if (_capturedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Veuillez capturer une photo du PV avant de continuer.'),
        ),
      );
      return;
    }

    // Return the image to the previous screen
    Navigator.pop(context, _capturedImage);
  }

  // ================= EXIT SCREEN =================
  void _exitScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _exitScreen,
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                  ),
                  Image.asset(
                    'assets/VoteLedger_logo.png',
                    height: 34,
                    errorBuilder: (context, error, stackTrace) => 
                      const Text('VoteLedger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                  ),
                  const Icon(Icons.language, color: Colors.white, size: 24),
                ],
              ),
            ),

            // ================= TITLE =================
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 22),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF79BCEB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Capture du PV',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= DESCRIPTION =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Positionnez le document officiel dans le cadre. Assurez-vous que l’éclairage est suffisant.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ================= CAMERA AREA =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF07153A),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'AUTO-DÉTECTION ACTIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF79BCEB),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: _isCapturing
                                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                : _capturedImage == null
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.camera_alt_outlined, color: Colors.white38, size: 70),
                                          SizedBox(height: 14),
                                          Text('Aucune capture', style: TextStyle(color: Colors.white54, fontSize: 16)),
                                        ],
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.file(_capturedImage!, fit: BoxFit.cover),
                                      ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _capturedImage == null ? 'Aperçu de l’image' : 'Capture prête',
                            style: const TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ================= BOTTOM ACTION BAR =================
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 22),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // RESET / CANCEL
                  GestureDetector(
                    onTap: _resetImage,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: _capturedImage == null ? Colors.grey.shade300 : Colors.white,
                      child: Icon(Icons.close, color: _capturedImage == null ? Colors.grey : Colors.black87),
                    ),
                  ),

                  // CAPTURE BUTTON
                  GestureDetector(
                    onTap: _captureImage,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.camera_alt_outlined, color: Colors.black87, size: 42),
                        SizedBox(height: 6),
                        Text('capture', style: TextStyle(color: Colors.black, fontSize: 15, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),

                  // VALIDATE BUTTON
                  GestureDetector(
                    onTap: _validateImage,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: _capturedImage == null ? Colors.grey : const Color(0xFF79BCEB),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
