class ShopProcessingModel {
  final bool result;
  final ShopProcessingData? data;
  final String message;
  final List<dynamic> errors;

  ShopProcessingModel({
    required this.result,
    this.data,
    required this.message,
    required this.errors,
  });

  factory ShopProcessingModel.fromJson(Map<String, dynamic> json) {
    return ShopProcessingModel(
      result: json['result'],
      data: json['data'] != null
          ? ShopProcessingData.fromJson(json['data'])
          : null,
      message: json['message'] ?? '',
      errors: json['errors'] ?? [],
    );
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

class ShopProcessingData {
  final List<ShopProcessingShop> shops;

  ShopProcessingData({required this.shops});

  factory ShopProcessingData.fromJson(Map<String, dynamic> json) {
    return ShopProcessingData(
      shops: (json['shops'] as List)
          .map((shop) => ShopProcessingShop.fromJson(shop))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shops': shops.map((shop) => shop.toJson()).toList(),
    };
  }
}

class ShopProcessingShop {
  final int id;
  final int isActive;
  final String level;
  final int isPayoffCancelable;
  final int countryId;
  final int userId;
  final int categoryId;
  final String name;
  final String logo;
  final String description;
  final String phone;
  final String website;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int hasEditRights;
  final String logoFullUrl;
  final List<ShopProcessingLocation> locations;

  ShopProcessingShop({
    required this.id,
    required this.isActive,
    required this.level,
    required this.isPayoffCancelable,
    required this.countryId,
    required this.userId,
    required this.categoryId,
    required this.name,
    required this.logo,
    required this.description,
    required this.phone,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.hasEditRights,
    required this.logoFullUrl,
    required this.locations,
  });

  factory ShopProcessingShop.fromJson(Map<String, dynamic> json) {
    return ShopProcessingShop(
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
      hasEditRights: json['has_edit_rights'],
      logoFullUrl: json['logo_full_url'],
      locations: (json['locations'] as List)
          .map((location) => ShopProcessingLocation.fromJson(location))
          .toList(),
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
      'has_edit_rights': hasEditRights,
      'logo_full_url': logoFullUrl,
      'locations': locations.map((location) => location.toJson()).toList(),
    };
  }
}

class ShopProcessingLocation {
  final int id;
  final int shopId;
  final String name;
  final String zipcode;
  final String address;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  ShopProcessingLocation({
    required this.id,
    required this.shopId,
    required this.name,
    required this.zipcode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ShopProcessingLocation.fromJson(Map<String, dynamic> json) {
    return ShopProcessingLocation(
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
    };
  }
}
