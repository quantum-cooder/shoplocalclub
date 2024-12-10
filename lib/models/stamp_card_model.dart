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
  String? activePoints;
  Shop? shop;
  StampCard? stampcard;
  List<Stamp>? stamps;

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
    this.activePoints,
    this.shop,
    this.stampcard,
    this.stamps,
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
      activePoints: json['active_points'],
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
      stampcard: json['stampcard'] != null
          ? StampCard.fromJson(json['stampcard'])
          : null,
      stamps: (json['stamps'] as List?)
          ?.map((item) => Stamp.fromJson(item))
          .toList(),
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
      'active_points': activePoints,
      'shop': shop?.toJson(),
      'stampcard': stampcard?.toJson(),
    };
  }
}

class Voucher {
  final String? message;
  final String? expireDays;
  final int? id;
  final double? value;

  Voucher({
    this.message,
    this.expireDays,
    this.id,
    this.value,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      message: json['message'] as String?,
      expireDays: json['expireDays'] as String?,
      id: json['id'] as int?,
      value: (json['value'] as num?)?.toDouble(),
    );
  }
}

class Offer {
  final String? description;
  final String? imageUrl;

  Offer({
    this.description,
    this.imageUrl,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

class Shop {
  int? id;
  int? isActive;
  String? level;
  int? isPayoffCancelable;
  int? countryId;
  int? userId;
  String? categoryId;
  String? name;
  String? logo;
  String? description;
  String? phone;
  String? website;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isFavorite;
  ClosestLocation? closestLocation;
  String? logoFullUrl;
  Category? category;

  Shop({
    this.id,
    this.isActive,
    this.level,
    this.isPayoffCancelable,
    this.countryId,
    this.userId,
    this.categoryId,
    this.name,
    this.logo,
    this.description,
    this.phone,
    this.website,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isFavorite,
    this.closestLocation,
    this.logoFullUrl,
    this.category,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      isActive: json['is_active'],
      level: json['level'],
      isPayoffCancelable: json['is_payoff_cancelable'],
      countryId: json['country_id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      name: json['name'],
      logo: json['logo'],
      description: json['description'],
      phone: json['phone'],
      website: json['website'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      isFavorite: json['is_favorite'],
      closestLocation: json['closest_location'] != null
          ? ClosestLocation.fromJson(json['closest_location'])
          : null,
      logoFullUrl: json['logo_full_url'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'level': level,
      'is_payoff_cancelable': isPayoffCancelable,
      'country_id': countryId,
      'user_id': userId,
      'category_id': categoryId,
      'name': name,
      'logo': logo,
      'description': description,
      'phone': phone,
      'website': website,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'is_favorite': isFavorite,
      'closest_location': closestLocation?.toJson(),
      'logo_full_url': logoFullUrl,
      'category': category?.toJson(),
    };
  }
}

class ClosestLocation {
  int? id;
  int? shopId;
  String? name;
  String? zipcode;
  String? address;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  double? distanceKm;
  bool? isCheckedIn;

  ClosestLocation({
    this.id,
    this.shopId,
    this.name,
    this.zipcode,
    this.address,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.distanceKm,
    this.isCheckedIn,
  });

  factory ClosestLocation.fromJson(Map<String, dynamic> json) {
    return ClosestLocation(
      id: json['id'],
      shopId: json['shop_id'],
      name: json['name'],
      zipcode: json['zipcode'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      distanceKm: json['distance_km']?.toDouble(),
      isCheckedIn: json['is_checked_in'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'name': name,
      'zipcode': zipcode,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'distance_km': distanceKm,
      'is_checked_in': isCheckedIn,
    };
  }
}

class Category {
  int? id;
  String? title;
  String? slug;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Category({
    this.id,
    this.title,
    this.slug,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class StampCard {
  int? id;
  int? isActive;
  int? shopId;
  String? description;
  String? conditions;
  int? stampsTotal;
  int? stampIcoId;
  int? expireDays;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? rewardText;

  StampCard({
    this.id,
    this.isActive,
    this.shopId,
    this.description,
    this.conditions,
    this.stampsTotal,
    this.stampIcoId,
    this.expireDays,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.rewardText,
  });

  factory StampCard.fromJson(Map<String, dynamic> json) {
    return StampCard(
      id: json['id'],
      isActive: json['is_active'],
      shopId: json['shop_id'],
      description: json['description'],
      conditions: json['conditions'],
      stampsTotal: json['stamps_total'],
      stampIcoId: json['stamp_ico_id'],
      expireDays: json['expire_days'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      rewardText: json['reward_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'shop_id': shopId,
      'description': description,
      'conditions': conditions,
      'stamps_total': stampsTotal,
      'stamp_ico_id': stampIcoId,
      'expire_days': expireDays,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'reward_text': rewardText,
    };
  }
}

class Stamp {
  int? id;
  int? stampcardUserId;
  int? operatorUserId;
  int? locationId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Stamp({
    this.id,
    this.stampcardUserId,
    this.operatorUserId,
    this.locationId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Stamp.fromJson(Map<String, dynamic> json) {
    return Stamp(
      id: json['id'],
      stampcardUserId: json['stampcard_user_id'],
      operatorUserId: json['operator_user_id'],
      locationId: json['location_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stampcard_user_id': stampcardUserId,
      'operator_user_id': operatorUserId,
      'location_id': locationId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
