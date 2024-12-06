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
  List<Voucher>? vouchers;

  VoucherData({this.vouchers});

  factory VoucherData.fromJson(Map<String, dynamic> json) {
    return VoucherData(
      vouchers: (json['vouchers'] as List?)
          ?.map((voucherJson) => Voucher.fromJson(voucherJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vouchers': vouchers?.map((voucher) => voucher.toJson()).toList(),
    };
  }
}

class Voucher {
  int? id;
  int? isActive;
  String? code;
  int? shopId;
  int? value;
  String? type;
  int? expireDays;
  String? message;
  String? conditions;
  int? valueToPointsCurrency;
  int? valueToPointsPoints;
  int? pointsToValueCurrency;
  int? pointsToValuePoints;
  int? minPoints;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Voucher({
    this.id,
    this.isActive,
    this.code,
    this.shopId,
    this.value,
    this.type,
    this.expireDays,
    this.message,
    this.conditions,
    this.valueToPointsCurrency,
    this.valueToPointsPoints,
    this.pointsToValueCurrency,
    this.pointsToValuePoints,
    this.minPoints,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      isActive: json['is_active'],
      code: json['code'],
      shopId: json['shop_id'],
      value: json['value'],
      type: json['type'],
      expireDays: json['expire_days'],
      message: json['message'],
      conditions: json['conditions'],
      valueToPointsCurrency: json['value_to_points_currency'],
      valueToPointsPoints: json['value_to_points_points'],
      pointsToValueCurrency: json['points_to_value_currency'],
      pointsToValuePoints: json['points_to_value_points'],
      minPoints: json['min_points'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'code': code,
      'shop_id': shopId,
      'value': value,
      'type': type,
      'expire_days': expireDays,
      'message': message,
      'conditions': conditions,
      'value_to_points_currency': valueToPointsCurrency,
      'value_to_points_points': valueToPointsPoints,
      'points_to_value_currency': pointsToValueCurrency,
      'points_to_value_points': pointsToValuePoints,
      'min_points': minPoints,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
