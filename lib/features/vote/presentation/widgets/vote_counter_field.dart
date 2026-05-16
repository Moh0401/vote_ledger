import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoteCounterField extends StatelessWidget {

  final String label;
  final Function(String) onChanged;

  const VoteCounterField({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5E5E5E),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 6),

        TextFormField(
          keyboardType: TextInputType.number,

          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],

          onChanged: onChanged,

          style: const TextStyle(
            color: Color(0xFF6D7480),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),

          decoration: InputDecoration(
            hintText: '0',

            hintStyle: const TextStyle(
              color: Color(0xFF6D7480),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),

            filled: true,
            fillColor: const Color(0xFFE9E9E9),

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8),

              borderSide: const BorderSide(
                color: Color(0xFF6FA8DC),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}