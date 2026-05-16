class AgentEntity {
  final int id;
  final String username;
  final String bureauId;
  final String fullName;
  final String centreDeVote;
  final String region;
  final String role;
  final int nombreVotants;
  final bool isSubmitted;

  AgentEntity({
    required this.id,
    required this.username,
    required this.bureauId,
    required this.fullName,
    required this.centreDeVote,
    required this.region,
    required this.role,
    this.nombreVotants = 0,
    this.isSubmitted = false,
  });
}
