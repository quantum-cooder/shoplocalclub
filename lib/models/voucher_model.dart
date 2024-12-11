class VoucherModel {
  bool? result;
  VoucherData? data;
  String? message;
  List<dynamic>? errors;

  // Singleton instance
  static VoucherModel? _voucherModel;

  VoucherModel({this.result, this.data, this.message, this.errors});

  // Getter to access the instance globally
  static VoucherModel? get instance => _voucherModel;

  // Check if data is already loaded
  static bool get hasData => _voucherModel != null;

  // Factory method to parse JSON and set the singleton instance
  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    _voucherModel = VoucherModel(
      result: json['result'],
      data: json['data'] != null ? VoucherData.fromJson(json['data']) : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );
    return _voucherModel!;
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

class VoucherData {
  List<MembershipCardVoucher>? membershipcardVouchers;

  VoucherData({this.membershipcardVouchers});

  factory VoucherData.fromJson(Map<String, dynamic> json) {
    return VoucherData(
      membershipcardVouchers: json['membershipcardVouchers'] != null
          ? (json['membershipcardVouchers'] as List)
              .map((item) => MembershipCardVoucher.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'membershipcardVouchers':
          membershipcardVouchers?.map((e) => e.toJson()).toList(),
    };
  }
}

class MembershipCardVoucher {
  int? id;
  String? code;
  int? membershipcardId;
  int? voucherId;
  int? shopId;
  int? value;
  String? type;
  String? expiresAt;
  String? message;
  String? conditions;
  String? paidOffAt;
  int? paidOffOperatorUserId;
  int? paidOffLocationId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? activePoints;
  bool? isFavorite;
  Shop? shop;
  dynamic operatorUser;
  dynamic paidOffLocation;

  MembershipCardVoucher({
    this.id,
    this.code,
    this.membershipcardId,
    this.voucherId,
    this.shopId,
    this.value,
    this.type,
    this.expiresAt,
    this.message,
    this.conditions,
    this.paidOffAt,
    this.paidOffOperatorUserId,
    this.paidOffLocationId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.activePoints,
    this.isFavorite,
    this.shop,
    this.operatorUser,
    this.paidOffLocation,
  });

  factory MembershipCardVoucher.fromJson(Map<String, dynamic> json) {
    return MembershipCardVoucher(
      id: json['id'],
      code: json['code'],
      membershipcardId: json['membershipcard_id'],
      voucherId: json['voucher_id'],
      shopId: json['shop_id'],
      value: json['value'],
      type: json['type'],
      expiresAt: json['expires_at'],
      message: json['message'],
      conditions: json['conditions'],
      paidOffAt: json['paid_off_at'],
      paidOffOperatorUserId: json['paid_off_operator_user_id'],
      paidOffLocationId: json['paid_off_location_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      activePoints: json['active_points'],
      isFavorite: json['is_favorite'] != null ? true : false,
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
      operatorUser: json['operator_user'],
      paidOffLocation: json['paid_off_location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'membershipcard_id': membershipcardId,
      'voucher_id': voucherId,
      'shop_id': shopId,
      'value': value,
      'type': type,
      'expires_at': expiresAt,
      'message': message,
      'conditions': conditions,
      'paid_off_at': paidOffAt,
      'paid_off_operator_user_id': paidOffOperatorUserId,
      'paid_off_location_id': paidOffLocationId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'active_points': activePoints,
      'is_favorite': isFavorite,
      'shop': shop?.toJson(),
      'operator_user': operatorUser,
      'paid_off_location': paidOffLocation,
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

  IsFavorite(
      {this.id,
      this.userId,
      this.shopId,
      this.locationId,
      this.createdAt,
      this.updatedAt});

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
  int? categoryId;
  String? name;
  String? logo;
  String? description;
  String? phone;
  String? website;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ClosestLocation? closestLocation;
  String? logoFullUrl;

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
    this.closestLocation,
    this.logoFullUrl,
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
      closestLocation: json['closest_location'] != null
          ? ClosestLocation.fromJson(json['closest_location'])
          : null,
      logoFullUrl: json['logo_full_url'],
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
      'closest_location': closestLocation?.toJson(),
      'logo_full_url': logoFullUrl,
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
