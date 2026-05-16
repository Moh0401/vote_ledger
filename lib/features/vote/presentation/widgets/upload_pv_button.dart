import 'package:flutter/material.dart';

class UploadPvButton extends StatelessWidget {
  final VoidCallback onTap;

  const UploadPvButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF79BCEB),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: Color(0xFF79BCEB),
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              'Ajouter la photo du PV',
              style: TextStyle(
                color: Color(0xFF79BCEB),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
