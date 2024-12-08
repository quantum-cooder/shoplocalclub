import 'dart:developer';

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
    if (json['result'] == true && json['data'] != null) {
      _shopModel = ShopModel(
        result: json['result'],
        data: ShopData.fromJson(json['data']),
        message: json['message'],
        errors:
            json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
      );
    } else {
      log('Invalid response: ${json.toString()}');
    }
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
  Shop? shop; // The actual Shop object from the API response.

  ShopData({this.locations, this.shop});

  factory ShopData.fromJson(Map<String, dynamic> json) {
    return ShopData(
      locations: json['locations'] != null
          ? (json['locations'] as List)
              .map((location) => Location.fromJson(location))
              .toList()
          : null,
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locations': locations?.map((location) => location.toJson()).toList(),
      'shop': shop?.toJson(),
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
  List<Location>? locations;

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
    this.locations,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'] ?? ''),
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
      locations: (json['locations'] as List<dynamic>?)
          ?.map((location) => Location.fromJson(location))
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
      'logo_full_url': logoFullUrl,
      'locations': locations?.map((location) => location.toJson()).toList(),
    };
  }
}

class Location {
  int? id;
  int? shopId;
  String? name;
  String? zipcode;
  String? address;
  String? latitude; // Ensure these remain as String.
  String? longitude; // Ensure these remain as String.
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

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
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'] ?? ''),
      shopId: json['shop_id'] is int
          ? json['shop_id']
          : int.tryParse(json['shop_id'] ?? ''),
      name: json['name'],
      zipcode: json['zipcode'],
      address: json['address'],
      latitude: json['latitude'], // API returns String, no parsing needed.
      longitude: json['longitude'], // API returns String, no parsing needed.
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
