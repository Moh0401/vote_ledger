import '../../domain/entities/agent_entity.dart';

class AgentModel extends AgentEntity {
  AgentModel({
    required super.id,
    required super.username,
    required super.bureauId,
    required super.fullName,
    required super.centreDeVote,
    required super.region,
    required super.role,
    super.nombreVotants,
    super.isSubmitted,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      id: json['id'],
      username: json['username'],
      bureauId: json['bureauId'],
      fullName: json['fullName'],
      centreDeVote: json['centreDeVote'] ?? 'Non assigné',
      region: json['region'] ?? 'Non assignée',
      role: json['role'] ?? 'ROLE_AGENT',
      nombreVotants: json['nombreVotants'] ?? 0,
      isSubmitted: json['isSubmitted'] ?? false,
    );
  }
}
