import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/domain/entities/agent_entity.dart';
import '../providers/vote_form_provider.dart';
import '../widgets/total_votes_card.dart';
import '../widgets/upload_pv_button.dart';
import '../widgets/vote_counter_field.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final agent = ModalRoute.of(context)?.settings.arguments as AgentEntity?;

    return ChangeNotifierProvider(
      create: (_) => VoteFormProvider(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                                  const Icon(Icons.how_to_vote,
                                      color: Colors.white),
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

                        const SizedBox(height: 28),

                        // ================= TITLE =================
                        const Text(
                          'Saisie des résultats',
                          style: TextStyle(
                            color: Color(0xFF79BCEB),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Enregistrement des votes du bureau',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ================= FORM CARD =================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Consumer<VoteFormProvider>(
                            builder: (context, provider, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ================= TOP CARD =================
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF79BCEB),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'BUREAU DE VOTE ID',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          agent?.bureauId ?? 'BKO-IV-22-09',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // ================= CANDIDATS =================
                                  VoteCounterField(
                                    label: 'CANDIDAT 1',
                                    onChanged: provider.updateCandidate1,
                                  ),
                                  const SizedBox(height: 16),
                                  VoteCounterField(
                                    label: 'CANDIDAT 2',
                                    onChanged: provider.updateCandidate2,
                                  ),
                                  const SizedBox(height: 16),
                                  VoteCounterField(
                                    label: 'CANDIDAT 3',
                                    onChanged: provider.updateCandidate3,
                                  ),
                                  const SizedBox(height: 16),
                                  VoteCounterField(
                                    label: 'CANDIDAT 4',
                                    onChanged: provider.updateCandidate4,
                                  ),
                                  const SizedBox(height: 16),
                                  VoteCounterField(
                                    label: 'CANDIDAT 5',
                                    onChanged: provider.updateCandidate5,
                                  ),
                                  const SizedBox(height: 16),
                                  VoteCounterField(
                                    label: 'VOTES NULS',
                                    onChanged: provider.updateNullVotes,
                                  ),

                                  const SizedBox(height: 22),

                                  // ================= TOTAL =================
                                  TotalVotesCard(
                                    total: provider.totalVotes,
                                  ),

                                  const SizedBox(height: 22),

                                  // ================= UPLOAD BUTTON =================
                                  provider.isSubmitting
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : UploadPvButton(
                                          onTap: () async {
                                            final result =
                                                await Navigator.pushNamed(
                                              context,
                                              '/capture-pv',
                                            );

                                            if (result is File &&
                                                context.mounted) {
                                              provider.setCapturedImage(result);
                                              _showConfirmationDialog(
                                                  context, provider, agent);
                                            }
                                          },
                                        ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 100), // Space for bottom nav
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ================= FIXED BOTTOM NAV =================
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
                      color: Colors.black.withOpacity(0.2),
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
                        Navigator.pushReplacementNamed(context, '/dashboard',
                            arguments: agent);
                      },
                    ),
                    _buildNavItem(
                      context: context,
                      icon: Icons.how_to_vote_outlined,
                      selected: true,
                      onTap: () {},
                    ),
                    _buildNavItem(
                      context: context,
                      icon: Icons.person_outline,
                      selected: false,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/profile',
                            arguments: agent);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, VoteFormProvider provider, AgentEntity? agent) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text("Certifier le PV ?",
            style: TextStyle(color: Colors.white)),
        content: Text(
            "Vous allez soumettre un total de ${provider.totalVotes} voix pour le bureau ${agent?.bureauId ?? 'BKO-IV-22-09'}. Cette action est irréversible.",
            style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Annuler", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                
                navigator.pop(); // Ferme le dialogue

                final success = await provider.submitResults(
                    agent?.bureauId ?? "BKO-IV-22-09",
                    agent?.username ?? "UNKNOWN");

                if (success) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text("✅ PV enregistré et sécurisé sur la Blockchain !"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // On essaye de récupérer les données fraîches du serveur
                  AgentEntity? updatedAgent = await provider.getUpdatedAgent(agent?.username ?? "");

                  // Fallback si le serveur ne répond pas assez vite
                  updatedAgent ??= AgentEntity(
                    id: agent?.id ?? 0,
                    username: agent?.username ?? "UNKNOWN",
                    bureauId: agent?.bureauId ?? "UNKNOWN",
                    fullName: agent?.fullName ?? "Agent",
                    centreDeVote: agent?.centreDeVote ?? "",
                    region: agent?.region ?? "",
                    role: agent?.role ?? "ROLE_AGENT",
                    nombreVotants: provider.totalVotes,
                    isSubmitted: true,
                  );

                  navigator.pushNamedAndRemoveUntil(
                      '/dashboard', (route) => false,
                      arguments: updatedAgent);
                } else {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                        content: Text("Erreur lors de la soumission"),
                        backgroundColor: Colors.redAccent),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF79BCEB)),
              child: const Text("Confirmer et Signer",
                  style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  // ================= NAV ITEM =================
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
