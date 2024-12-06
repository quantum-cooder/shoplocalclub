class StampCardModel {
  bool? result;
  StampCardData? data;
  String? message;
  List<dynamic>? errors;

  // Singleton instance
  static StampCardModel? _stampCardModel;

  StampCardModel({this.result, this.data, this.message, this.errors});

  // Getter to access the instance globally
  static StampCardModel? get instance => _stampCardModel;

  // Check if data is already loaded
  static bool get hasData => _stampCardModel != null;

  // Factory method to parse JSON and set the singleton instance
  factory StampCardModel.fromJson(Map<String, dynamic> json) {
    _stampCardModel = StampCardModel(
      result: json['result'],
      data: json['data'] != null ? StampCardData.fromJson(json['data']) : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
    return _stampCardModel!;
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data?.toJson(),
      'message': message,
      'errors': errors,
    };
  }
}

class StampCardData {
  List<StampCardUser>? stampcardUsers;

  StampCardData({this.stampcardUsers});

  factory StampCardData.fromJson(Map<String, dynamic> json) {
    return StampCardData(
      stampcardUsers: (json['stampcardUsers'] as List?)
          ?.map((item) => StampCardUser.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stampcardUsers': stampcardUsers?.map((item) => item.toJson()).toList(),
    };
  }
}

class StampCardUser {
  int? id;
  int? isActive;
  int? membershipcardId;
  int? stampcardId;
  String? initiatedBy;
  String? expiresAt;
  int? points;
  String? description;
  String? conditions;
  int? stampsTotal;
  String? rewardText;
  MembershipCard? membershipCard;

  StampCardUser({
    this.id,
    this.isActive,
    this.membershipcardId,
    this.stampcardId,
    this.initiatedBy,
    this.expiresAt,
    this.points,
    this.description,
    this.conditions,
    this.stampsTotal,
    this.rewardText,
    this.membershipCard,
  });

  factory StampCardUser.fromJson(Map<String, dynamic> json) {
    return StampCardUser(
      id: json['id'],
      isActive: json['is_active'],
      membershipcardId: json['membershipcard_id'],
      stampcardId: json['stampcard_id'],
      initiatedBy: json['initiated_by'],
      expiresAt: json['expires_at'],
      points: json['points'],
      description: json['description'],
      conditions: json['conditions'],
      stampsTotal: json['stamps_total'],
      rewardText: json['reward_text'],
      membershipCard: json['membershipcard'] != null
          ? MembershipCard.fromJson(json['membershipcard'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'membershipcard_id': membershipcardId,
      'stampcard_id': stampcardId,
      'initiated_by': initiatedBy,
      'expires_at': expiresAt,
      'points': points,
      'description': description,
      'conditions': conditions,
      'stamps_total': stampsTotal,
      'reward_text': rewardText,
      'membershipcard': membershipCard?.toJson(),
    };
  }
}

class MembershipCard {
  int? id;
  int? shopId;
  String? code;

  MembershipCard({this.id, this.shopId, this.code});

  factory MembershipCard.fromJson(Map<String, dynamic> json) {
    return MembershipCard(
      id: json['id'],
      shopId: json['shop_id'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'code': code,
    };
  }
}
