class ShopModel {
  bool? result;
  ShopData? data;
  String? message;
  List<dynamic>? errors;

  // Singleton instance
  static ShopModel? _shopModel;

  ShopModel({this.result, this.data, this.message, this.errors});

  // Getter to access the instance globally
  static ShopModel? get instance => _shopModel;

  // Check if data is already loaded
  static bool get hasData => _shopModel != null;

  // Factory method to parse JSON and set the singleton instance
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    _shopModel = ShopModel(
      result: json['result'],
      data: json['data'] != null ? ShopData.fromJson(json['data']) : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
    return _shopModel!;
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

class ShopData {
  List<Location>? locations;
  Meta? meta;

  ShopData({this.locations, this.meta});

  factory ShopData.fromJson(Map<String, dynamic> json) {
    return ShopData(
      locations: (json['locations'] as List)
          .map((locationJson) => Location.fromJson(locationJson))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locations': locations?.map((location) => location.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class Meta {
  int? radius;
  int? limit;
  int? offset;
  int? categoryId;
  int? favorite;
  String? order;
  String? orderType;
  String? latitude;
  String? longitude;
  int? total;

  Meta({
    this.radius,
    this.limit,
    this.offset,
    this.categoryId,
    this.favorite,
    this.order,
    this.orderType,
    this.latitude,
    this.longitude,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      radius: json['radius'],
      limit: json['limit'],
      offset: json['offset'],
      categoryId: json['category_id'],
      favorite: json['favorite'],
      order: json['order'],
      orderType: json['order_type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'radius': radius,
      'limit': limit,
      'offset': offset,
      'category_id': categoryId,
      'favorite': favorite,
      'order': order,
      'order_type': orderType,
      'latitude': latitude,
      'longitude': longitude,
      'total': total,
    };
  }
}

class Location {
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
  dynamic activePoints;
  dynamic totalVouchers;
  bool? isCheckedIn;
  IsFavorite? isFavorite;
  Shop? shop;

  Location({
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
    this.activePoints,
    this.totalVouchers,
    this.isCheckedIn,
    this.isFavorite,
    this.shop,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
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
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
      activePoints: json['active_points'],
      totalVouchers: json['total_vouchers'],
      isCheckedIn: json['is_checked_in'],
      isFavorite: json['is_favorite'] != null
          ? IsFavorite.fromJson(json['is_favorite'])
          : null,
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
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
      'active_points': activePoints,
      'total_vouchers': totalVouchers,
      'is_checked_in': isCheckedIn,
      'is_favorite': isFavorite?.toJson(),
      'shop': shop?.toJson(),
    };
  }
}

class IsFavorite {
  int? id;
  int? userId;
  int? shopId;
  int? locationId;
  String? createdAt;
  String? updatedAt;

  IsFavorite({
    this.id,
    this.userId,
    this.shopId,
    this.locationId,
    this.createdAt,
    this.updatedAt,
  });

  factory IsFavorite.fromJson(Map<String, dynamic> json) {
    return IsFavorite(
      id: json['id'],
      userId: json['user_id'],
      shopId: json['shop_id'],
      locationId: json['location_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'shop_id': shopId,
      'location_id': locationId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
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
  String? logoFullUrl;
  Category? category;
  StampCard? stampcard;

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
    this.logoFullUrl,
    this.category,
    this.stampcard,
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
      logoFullUrl: json['logo_full_url'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      stampcard: json['stampcard'] != null
          ? StampCard.fromJson(json['stampcard'])
          : null,
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
      'category': category?.toJson(),
      'stampcard': stampcard?.toJson(),
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
      'expire_days': expireDays,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'reward_text': rewardText,
    };
  }
}
