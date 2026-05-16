import 'package:flutter/material.dart';

class TotalVotesCard extends StatelessWidget {

  final int total;

  const TotalVotesCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),

        borderRadius:
            BorderRadius.circular(8),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Text(
            'TOTAL DES SUFFRAGES',
            style: TextStyle(
              color: Color(0xFF5E5E5E),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '$total',
            style: const TextStyle(
              color: Color(0xFF003B64),
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}