import 'package:flutter/material.dart';

import '../../../auth/domain/entities/agent_entity.dart';

class ProfileScreen extends StatelessWidget {
  // 1. On déclare la variable qui va recevoir les données
  final AgentEntity agent;

  // 2. On la rend obligatoire dans le constructeur
  const ProfileScreen({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      // ================= HEADER =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/VoteLedger_logo.png',
                                height: 34,
                                errorBuilder: (context, error, stackTrace) =>
                                const Text(
                                  'VoteLedger',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.language,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // ================= AVATAR =================
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5D9FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          size: 80,
                          color: Color(0xFF5D4BB4),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ================= WELCOME TEXT =================
                      const Text(
                        'BIENVENUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        // 3. Affichage du vrai nom de l'agent
                        agent.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ================= INFO FIELDS =================
                      // 4. Affichage des vraies données assignées par ton backend
                      _buildInfoField('Identifiant', agent.username),
                      const SizedBox(height: 20),
                      _buildInfoField('Numéro bureau', agent.bureauId),
                      const SizedBox(height: 20),
                      _buildInfoField('Centre de vote', agent.centreDeVote),
                      const SizedBox(height: 20),
                      _buildInfoField('Région', agent.region),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isKeyboardVisible
          ? null
          : Container(
        width: 170,
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context: context,
              icon: Icons.grid_view_rounded,
              selected: false,
              onTap: () {
                // On renvoie l'agent vers le dashboard pour ne pas perdre la donnée
                Navigator.pushReplacementNamed(context, '/dashboard', arguments: agent);
              },
            ),
            _buildNavItem(
              context: context,
              icon: Icons.how_to_vote_outlined,
              selected: false,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/form', arguments: agent);
              },
            ),
            _buildNavItem(
              context: context,
              icon: Icons.person,
              selected: true,
              onTap: () {}, // Déjà sur le profil
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}