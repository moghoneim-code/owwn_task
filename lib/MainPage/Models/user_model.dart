class UserModel {
  final String id;
  final String email;
  final String name;
  final String gender;
  final String status;
  final String partnerId;
  final DateTime createdAt;
  final dynamic statistics;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.status,
    required this.partnerId,
    required this.createdAt,
    this.statistics,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"].toString(),
        name: json["name"].toString(),
        email: json["email"] == null ? '' : json["email"].toString(),
        gender: json["gender"].toString(),
        status: json["status"].toString(),
        partnerId: json["partner_id"].toString(),
        createdAt: DateTime.parse(json["created_at"].toString()),
        statistics: json["statistics"] ?? [],
      );
}
