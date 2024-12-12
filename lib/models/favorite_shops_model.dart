class FavoriteShopsModel {
  bool? result;
  FavoriteShopsData? data;
  String? message;
  List<dynamic>? errors;

  // Singleton instance
  static FavoriteShopsModel? _instance;

  FavoriteShopsModel({this.result, this.data, this.message, this.errors});

  // Getter to access the instance globally
  static FavoriteShopsModel? get instance => _instance;

  // Check if data is already loaded
  static bool get hasData => _instance != null;

  // Factory method to parse JSON and set the singleton instance
  factory FavoriteShopsModel.fromJson(Map<String, dynamic> json) {
    _instance = FavoriteShopsModel(
      result: json['result'],
      data: json['data'] != null
          ? FavoriteShopsData.fromJson(json['data'])
          : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
    return _instance!;
  }
}

class FavoriteShopsData {
  final List<FavShopsLocation> locations;
  final FavShopsMeta meta;

  FavoriteShopsData({required this.locations, required this.meta});

  factory FavoriteShopsData.fromJson(Map<String, dynamic> json) {
    return FavoriteShopsData(
      locations: (json['locations'] as List)
          .map((location) => FavShopsLocation.fromJson(location))
          .toList(),
      meta: FavShopsMeta.fromJson(json['meta']),
    );
  }
}

class FavShopsLocation {
  final int id;
  final int shopId;
  final String name;
  final String zipcode;
  final String address;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;
  final double distanceKm;
  final String? activePoints;
  bool isCheckedIn;
  FavShopsIsFavorite? isFavorite;
  final FavShopsShop shop;

  FavShopsLocation({
    required this.id,
    required this.shopId,
    required this.name,
    required this.zipcode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.distanceKm,
    required this.activePoints,
    required this.isCheckedIn,
    this.isFavorite,
    required this.shop,
  });

  factory FavShopsLocation.fromJson(Map<String, dynamic> json) {
    return FavShopsLocation(
      id: json['id'],
      shopId: json['shop_id'],
      name: json['name'],
      zipcode: json['zipcode'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      distanceKm: json['distance_km'],
      activePoints: json['active_points'],
      isCheckedIn: json['is_checked_in'],
      isFavorite: json['is_favorite'] != null
          ? FavShopsIsFavorite.fromJson(json['is_favorite'])
          : null,
      shop: FavShopsShop.fromJson(json['shop']),
    );
  }
}

class FavShopsIsFavorite {
  final int id;
  final int userId;
  final int shopId;
  final int? locationId;
  final String createdAt;
  final String updatedAt;

  FavShopsIsFavorite({
    required this.id,
    required this.userId,
    required this.shopId,
    this.locationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavShopsIsFavorite.fromJson(Map<String, dynamic> json) {
    return FavShopsIsFavorite(
      id: json['id'],
      userId: json['user_id'],
      shopId: json['shop_id'],
      locationId: json['location_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class FavShopsShop {
  final int id;
  final int isActive;
  final String name;
  final String logo;
  final String description;
  final String phone;
  final String website;
  final String createdAt;
  final String updatedAt;
  final String logoFullUrl;
  final FavShopsCategory category;
  final FavShopsStampcard stampcard;

  FavShopsShop({
    required this.id,
    required this.isActive,
    required this.name,
    required this.logo,
    required this.description,
    required this.phone,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.logoFullUrl,
    required this.category,
    required this.stampcard,
  });

  factory FavShopsShop.fromJson(Map<String, dynamic> json) {
    return FavShopsShop(
      id: json['id'],
      isActive: json['is_active'],
      name: json['name'],
      logo: json['logo'],
      description: json['description'],
      phone: json['phone'],
      website: json['website'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      logoFullUrl: json['logo_full_url'],
      category: FavShopsCategory.fromJson(json['category']),
      stampcard: FavShopsStampcard.fromJson(json['stampcard']),
    );
  }
}

class FavShopsCategory {
  final int id;
  final String title;

  FavShopsCategory({
    required this.id,
    required this.title,
  });

  factory FavShopsCategory.fromJson(Map<String, dynamic> json) {
    return FavShopsCategory(
      id: json['id'],
      title: json['title'],
    );
  }
}

class FavShopsStampcard {
  final int id;
  final int isActive;
  final String description;
  final String conditions;
  final int stampsTotal;
  final int expireDays;
  final String rewardText;

  FavShopsStampcard({
    required this.id,
    required this.isActive,
    required this.description,
    required this.conditions,
    required this.stampsTotal,
    required this.expireDays,
    required this.rewardText,
  });

  factory FavShopsStampcard.fromJson(Map<String, dynamic> json) {
    return FavShopsStampcard(
      id: json['id'],
      isActive: json['is_active'],
      description: json['description'],
      conditions: json['conditions'],
      stampsTotal: json['stamps_total'],
      expireDays: json['expire_days'],
      rewardText: json['reward_text'],
    );
  }
}

class FavShopsMeta {
  final int radius;
  final int limit;
  final int offset;
  final int categoryId;
  final bool favorite;
  final String order;
  final String orderType;
  final String latitude;
  final String longitude;
  final int total;

  FavShopsMeta({
    required this.radius,
    required this.limit,
    required this.offset,
    required this.categoryId,
    required this.favorite,
    required this.order,
    required this.orderType,
    required this.latitude,
    required this.longitude,
    required this.total,
  });

  factory FavShopsMeta.fromJson(Map<String, dynamic> json) {
    return FavShopsMeta(
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
}
