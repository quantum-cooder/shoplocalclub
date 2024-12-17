class OperateShopModel {
  bool? result;
  ShopOperatorUserData? data;
  String? message;
  List<dynamic>? errors;

  // Singleton instance
  static OperateShopModel? _shopOperatorUserModel;

  OperateShopModel({this.result, this.data, this.message, this.errors});

  // Getter to access the instance globally
  static OperateShopModel? get instance => _shopOperatorUserModel;

  // Check if data is already loaded
  static bool get hasData => _shopOperatorUserModel != null;

  // Factory method to parse JSON and set the singleton instance
  factory OperateShopModel.fromJson(Map<String, dynamic> json) {
    _shopOperatorUserModel = OperateShopModel(
      result: json['result'],
      data: json['data'] != null
          ? ShopOperatorUserData.fromJson(json['data'])
          : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
    return _shopOperatorUserModel!;
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

class ShopOperatorUserData {
  ShopOperatorUserMembershipCard? membershipCard;

  ShopOperatorUserData({this.membershipCard});

  factory ShopOperatorUserData.fromJson(Map<String, dynamic> json) {
    return ShopOperatorUserData(
      membershipCard: json['membershipcard'] != null
          ? ShopOperatorUserMembershipCard.fromJson(json['membershipcard'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'membershipcard': membershipCard?.toJson(),
    };
  }
}

class ShopOperatorUserMembershipCard {
  int? id;
  int? userId;
  int? shopId;
  String? code;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? totalStamps;
  int? totalSales;
  String? totalPoints;
  List<dynamic>? activeVouchers;
  ShopOperatorUserStampcardUserShop? stampcardUserShop;
  ShopOperatorUser? user;

  ShopOperatorUserMembershipCard({
    this.id,
    this.userId,
    this.shopId,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.totalStamps,
    this.totalSales,
    this.totalPoints,
    this.activeVouchers,
    this.stampcardUserShop,
    this.user,
  });

  factory ShopOperatorUserMembershipCard.fromJson(Map<String, dynamic> json) {
    return ShopOperatorUserMembershipCard(
      id: json['id'],
      userId: json['user_id'],
      shopId: json['shop_id'],
      code: json['code'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      totalStamps: json['total_stamps'],
      totalSales: json['total_sales'],
      totalPoints: json['total_points'],
      activeVouchers: json['active_vouchers'] ?? [],
      stampcardUserShop: json['stampcardUserShop'] != null
          ? ShopOperatorUserStampcardUserShop.fromJson(
              json['stampcardUserShop'])
          : null,
      user:
          json['user'] != null ? ShopOperatorUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'shop_id': shopId,
      'code': code,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'total_stamps': totalStamps,
      'total_sales': totalSales,
      'total_points': totalPoints,
      'active_vouchers': activeVouchers,
      'stampcardUserShop': stampcardUserShop?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class ShopOperatorUserStampcardUserShop {
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
  String? createdAt;
  String? updatedAt;
  String? rewardText;
  ShopOperatorUserMembershipCard? membershipCard;

  ShopOperatorUserStampcardUserShop({
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
    this.createdAt,
    this.updatedAt,
    this.rewardText,
    this.membershipCard,
  });

  factory ShopOperatorUserStampcardUserShop.fromJson(
      Map<String, dynamic> json) {
    return ShopOperatorUserStampcardUserShop(
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      rewardText: json['reward_text'],
      membershipCard: json['membershipcard'] != null
          ? ShopOperatorUserMembershipCard.fromJson(json['membershipcard'])
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
      'created_at': createdAt,
      'updated_at': updatedAt,
      'reward_text': rewardText,
      'membershipcard': membershipCard?.toJson(),
    };
  }
}

class ShopOperatorUser {
  int? id;
  int? isActive;
  int? isVerified;
  int? isBanned;
  int? locationId;
  int? countryId;
  String? name;
  String? zipcode;
  String? latitude;
  String? longitude;
  String? locationUpdatedAt;
  String? lastActivity;
  String? createdAt;
  String? updatedAt;
  String? avatarFullUrl;

  ShopOperatorUser({
    this.id,
    this.isActive,
    this.isVerified,
    this.isBanned,
    this.locationId,
    this.countryId,
    this.name,
    this.zipcode,
    this.latitude,
    this.longitude,
    this.locationUpdatedAt,
    this.lastActivity,
    this.createdAt,
    this.updatedAt,
    this.avatarFullUrl,
  });

  factory ShopOperatorUser.fromJson(Map<String, dynamic> json) {
    return ShopOperatorUser(
      id: json['id'],
      isActive: json['is_active'],
      isVerified: json['is_verified'],
      isBanned: json['is_banned'],
      locationId: json['location_id'],
      countryId: json['country_id'],
      name: json['name'],
      zipcode: json['zipcode'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationUpdatedAt: json['location_updated_at'],
      lastActivity: json['last_activity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      avatarFullUrl: json['avatar_full_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'is_verified': isVerified,
      'is_banned': isBanned,
      'location_id': locationId,
      'country_id': countryId,
      'name': name,
      'zipcode': zipcode,
      'latitude': latitude,
      'longitude': longitude,
      'location_updated_at': locationUpdatedAt,
      'last_activity': lastActivity,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'avatar_full_url': avatarFullUrl,
    };
  }
}
