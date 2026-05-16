import 'package:flutter/material.dart';
import '../../../auth/domain/entities/agent_entity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String agentId = "ML-29384-BAM";
  final String stationName = "Station 42A";
  final String city = "Bamako, Mali";

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    
    // Récupération des données de l'agent si passées en argument
    final agent = ModalRoute.of(context)?.settings.arguments as AgentEntity?;
    
    final displayAgentId = agent?.username ?? agentId;
    final displayStationName = agent?.bureauId ?? stationName;
    final displayCity = agent?.region ?? city;
    final int displayVoters = agent?.nombreVotants ?? 0;
    final bool isSubmitted = agent?.isSubmitted ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),

              // ================= HEADER =================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/VoteLedger_logo.png',
                    height: 34,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.how_to_vote, color: Colors.white),
                  ),

                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1.2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 38),

              // ================= TITLE =================

              const Text(
                'Tableau de bord',
                style: TextStyle(
                  color: Color(0xFF79BCEB),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Agent ID: $displayAgentId',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 28),

              // ================= STATION CARD =================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BUREAU DE VOTE',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              displayStationName,
                              style: const TextStyle(
                                color: Color(0xFF79BCEB),
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSubmitted
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSubmitted ? Colors.green : Colors.orange,
                            ),
                          ),
                          child: Text(
                            isSubmitted ? "SOUMIS" : "EN ATTENTE",
                            style: TextStyle(
                              color: isSubmitted ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.black54,
                          size: 18,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          displayCity,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ================= STATS =================

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'VOTANTS',
                      value: '$displayVoters',
                      bordered: true,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _buildIntegrityCard(),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // ================= BUTTON =================

              if (!isSubmitted)
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/form',
                        arguments: agent,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF79BCEB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Soumettre les résultats',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Center(
                  child: Text(
                    "Résultats validés ✅",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

              const Spacer(),

              // ================= BOTTOM NAV =================

              if (!isKeyboardVisible)
                Center(
                  child: Container(
                    width: 170,
                    height: 62,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(
                          icon: Icons.grid_view_rounded,
                          selected: true,
                          onTap: () {},
                        ),

                        _buildNavItem(
                          icon: Icons.how_to_vote_outlined,
                          selected: false,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/form',
                              arguments: agent,
                            );
                          },
                        ),

                        _buildNavItem(
                          icon: Icons.person_outline,
                          selected: false,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/profile',
                              arguments: agent,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    bool bordered = false,
  }) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: bordered
            ? Border.all(
          color: const Color(0xFF79BCEB),
          width: 1.5,
        )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrityCard() {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: const [
          Text(
            'INTÉGRITÉ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Icon(
                Icons.shield_outlined,
                color: Color(0xFF79BCEB),
              ),

              SizedBox(width: 6),

              Text(
                'SÉCURISÉ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
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
          color:
          selected ? Colors.black : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color:
          selected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
