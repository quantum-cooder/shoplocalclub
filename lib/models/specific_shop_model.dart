class SpecificShopModel {
  bool? result;
  SpecificShopData? data;
  String? message;
  List<dynamic>? errors;

  // Singleton instance
  static SpecificShopModel? _specificShopModel;

  SpecificShopModel({this.result, this.data, this.message, this.errors});

  // Getter to access the instance globally
  static SpecificShopModel? get instance => _specificShopModel;

  // Check if data is already loaded
  static bool get hasData => _specificShopModel != null;

  // Factory method to parse JSON and set the singleton instance
  factory SpecificShopModel.fromJson(Map<String, dynamic> json) {
    _specificShopModel = SpecificShopModel(
      result: json['result'],
      data:
          json['data'] != null ? SpecificShopData.fromJson(json['data']) : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
    return _specificShopModel!;
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

class SpecificShopData {
  SpecificShopLocation? location;

  SpecificShopData({this.location});

  factory SpecificShopData.fromJson(Map<String, dynamic> json) {
    return SpecificShopData(
      location: json['location'] != null
          ? SpecificShopLocation.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
    };
  }
}

class SpecificShopLocation {
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
  int? totalVouchers;
  String? subscription;
  SpecificShopDetails? shop;

  SpecificShopLocation({
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
    this.totalVouchers,
    this.subscription,
    this.shop,
  });

  factory SpecificShopLocation.fromJson(Map<String, dynamic> json) {
    return SpecificShopLocation(
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
      totalVouchers: json['total_vouchers'],
      subscription: json['subscription'],
      shop: json['shop'] != null
          ? SpecificShopDetails.fromJson(json['shop'])
          : null,
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
      'total_vouchers': totalVouchers,
      'subscription': subscription,
      'shop': shop?.toJson(),
    };
  }
}

class SpecificShopDetails {
  int? id;
  int? isActive;
  String? level;
  int? isPayoffCancelable;
  int? countryId;
  int? userId;
  int? categoryId;
  String? name;
  String? logo;
  String? description;
  String? phone;
  String? website;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? logoFullUrl;
  SpecificShopStampCard? stampCard;
  SpecificShopUser? user;

  SpecificShopDetails({
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
    this.logoFullUrl,
    this.stampCard,
    this.user,
  });

  factory SpecificShopDetails.fromJson(Map<String, dynamic> json) {
    return SpecificShopDetails(
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
      logoFullUrl: json['logo_full_url'],
      stampCard: json['stampcard'] != null
          ? SpecificShopStampCard.fromJson(json['stampcard'])
          : null,
      user:
          json['user'] != null ? SpecificShopUser.fromJson(json['user']) : null,
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
      'logo_full_url': logoFullUrl,
      'stampcard': stampCard?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class SpecificShopStampCard {
  int? id;
  int? isActive;
  int? shopId;
  String? description;
  String? conditions;
  int? stampsTotal;
  int? expireDays;
  String? rewardText;

  SpecificShopStampCard({
    this.id,
    this.isActive,
    this.shopId,
    this.description,
    this.conditions,
    this.stampsTotal,
    this.expireDays,
    this.rewardText,
  });

  factory SpecificShopStampCard.fromJson(Map<String, dynamic> json) {
    return SpecificShopStampCard(
      id: json['id'],
      isActive: json['is_active'],
      shopId: json['shop_id'],
      description: json['description'],
      conditions: json['conditions'],
      stampsTotal: json['stamps_total'],
      expireDays: json['expire_days'],
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
      'expire_days': expireDays,
      'reward_text': rewardText,
    };
  }
}

class SpecificShopUser {
  int? id;
  String? name;
  String? email;

  SpecificShopUser({
    this.id,
    this.name,
    this.email,
  });

  factory SpecificShopUser.fromJson(Map<String, dynamic> json) {
    return SpecificShopUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
