class UserProfileModel {
  static UserProfileModel? _instance;

  bool? result;
  String? message;
  List<dynamic>? errors;
  int? id;
  int? isActive;
  int? isVerified;
  int? isBanned;
  String? avatar;
  String? name;
  String? email;
  String? zipcode;
  String? lastActivity;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? locationId;
  int? countryId;
  String? locationUpdatedAt;
  String? avatarFullUrl;
  MembershipCard? membershipCard;
  Country? country;

  UserProfileModel({
    this.result,
    this.message,
    this.errors,
    this.id,
    this.isActive,
    this.isVerified,
    this.isBanned,
    this.avatar,
    this.name,
    this.email,
    this.zipcode,
    this.lastActivity,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.locationId,
    this.countryId,
    this.locationUpdatedAt,
    this.avatarFullUrl,
    this.membershipCard,
    this.country,
  });

  static const String keyResult = 'result';
  static const String keyMessage = 'message';
  static const String keyErrors = 'errors';
  static const String keyId = 'id';
  static const String keyIsActive = 'is_active';
  static const String keyIsVerified = 'is_verified';
  static const String keyIsBanned = 'is_banned';
  static const String keyAvatar = 'avatar';
  static const String keyName = 'name';
  static const String keyEmail = 'email';
  static const String keyZipcode = 'zipcode';
  static const String keyLastActivity = 'last_activity';
  static const String keyLatitude = 'latitude';
  static const String keyLongitude = 'longitude';
  static const String keyCreatedAt = 'created_at';
  static const String keyUpdatedAt = 'updated_at';
  static const String keyDeletedAt = 'deleted_at';
  static const String keyLocationId = 'location_id';
  static const String keyCountryId = 'country_id';
  static const String keyLocationUpdatedAt = 'location_updated_at';
  static const String keyAvatarFullUrl = 'avatar_full_url';
  static const String keyMembershipCard = 'membershipcard';
  static const String keyCountry = 'country';

  static UserProfileModel get instance {
    if (_instance == null) {
      throw Exception(
          'UserProfileModel has not been initialized. Call fromJson() first.');
    }
    return _instance!;
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    _instance = UserProfileModel(
      result: json[keyResult],
      message: json[keyMessage],
      errors: json[keyErrors],
      id: json['data']['user'][keyId],
      isActive: json['data']['user'][keyIsActive],
      isVerified: json['data']['user'][keyIsVerified],
      isBanned: json['data']['user'][keyIsBanned],
      avatar: json['data']['user'][keyAvatar],
      name: json['data']['user'][keyName],
      email: json['data']['user'][keyEmail],
      zipcode: json['data']['user'][keyZipcode],
      lastActivity: json['data']['user'][keyLastActivity],
      latitude: json['data']['user'][keyLatitude],
      longitude: json['data']['user'][keyLongitude],
      createdAt: json['data']['user'][keyCreatedAt],
      updatedAt: json['data']['user'][keyUpdatedAt],
      deletedAt: json['data']['user'][keyDeletedAt],
      locationId: json['data']['user'][keyLocationId],
      countryId: json['data']['user'][keyCountryId],
      locationUpdatedAt: json['data']['user'][keyLocationUpdatedAt],
      avatarFullUrl: json['data']['user'][keyAvatarFullUrl],
      membershipCard: json['data']['user'][keyMembershipCard] != null
          ? MembershipCard.fromJson(json['data']['user'][keyMembershipCard])
          : null,
      country: json['data']['user'][keyCountry] != null
          ? Country.fromJson(json['data']['user'][keyCountry])
          : null,
    );

    return _instance!;
  }
}

class MembershipCard {
  int? id;
  int? userId;
  int? shopId;
  String? code;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  MembershipCard({
    this.id,
    this.userId,
    this.shopId,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  static const String keyId = 'id';
  static const String keyUserId = 'user_id';
  static const String keyShopId = 'shop_id';
  static const String keyCode = 'code';
  static const String keyName = 'name';
  static const String keyCreatedAt = 'created_at';
  static const String keyUpdatedAt = 'updated_at';
  static const String keyDeletedAt = 'deleted_at';

  factory MembershipCard.fromJson(Map<String, dynamic> json) {
    return MembershipCard(
      id: json[keyId],
      userId: json[keyUserId],
      shopId: json[keyShopId],
      code: json[keyCode],
      name: json[keyName],
      createdAt: json[keyCreatedAt],
      updatedAt: json[keyUpdatedAt],
      deletedAt: json[keyDeletedAt],
    );
  }
}

class Country {
  int? id;
  int? isActive;
  String? name;
  String? code;
  String? dateFormat;
  String? currencySymbol;
  String? cardCode;
  int? distance;
  String? unit;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Country({
    this.id,
    this.isActive,
    this.name,
    this.code,
    this.dateFormat,
    this.currencySymbol,
    this.cardCode,
    this.distance,
    this.unit,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  static const String keyId = 'id';
  static const String keyIsActive = 'is_active';
  static const String keyName = 'name';
  static const String keyCode = 'code';
  static const String keyDateFormat = 'date_format';
  static const String keyCurrencySymbol = 'currency_symbol';
  static const String keyCardCode = 'card_code';
  static const String keyDistance = 'distance';
  static const String keyUnit = 'unit';
  static const String keyCreatedAt = 'created_at';
  static const String keyUpdatedAt = 'updated_at';
  static const String keyDeletedAt = 'deleted_at';

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json[keyId],
      isActive: json[keyIsActive],
      name: json[keyName],
      code: json[keyCode],
      dateFormat: json[keyDateFormat],
      currencySymbol: json[keyCurrencySymbol],
      cardCode: json[keyCardCode],
      distance: json[keyDistance],
      unit: json[keyUnit],
      createdAt: json[keyCreatedAt],
      updatedAt: json[keyUpdatedAt],
      deletedAt: json[keyDeletedAt],
    );
  }
}
