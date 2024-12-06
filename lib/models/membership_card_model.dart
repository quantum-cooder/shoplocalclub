class MembershipCard {
  static MembershipCard? _cardInstance;

  final int id;
  final int userId;
  final int? shopId;
  final String code;
  final String? name;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  MembershipCard({
    required this.id,
    required this.userId,
    this.shopId,
    required this.code,
    this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  MembershipCard get memberShipCard {
    if (_cardInstance == null) {
      throw Exception(
          'Constructor MembershipCard is not initilized. please initilize it first');
    }
    return _cardInstance!;
  }

  factory MembershipCard.fromJson(Map<String, dynamic> json) {
    _cardInstance = MembershipCard(
      id: json['id'],
      userId: json['user_id'],
      shopId: json['shop_id'],
      code: json['code'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
    return _cardInstance!;
  }
}
