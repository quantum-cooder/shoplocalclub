class ApiEndPoints {
  static const String baseUrl = 'https://api.shoplocalclubcard.com';
  static const Map<String, String> apiHeaders = {
    'Content-Type': 'application/json'
  };
  static const int successCode = 200;

  ///user end points
  static const String userEndPoint = '$baseUrl/api/v1/user';
  static const String checkEmail = '$userEndPoint/check_email';
  static const String registerUser = '$userEndPoint/register';
  static const String updateProfile = '$userEndPoint/profile_save';
  static const String checkInLocations = '$userEndPoint/check_in_locations';

  ///this end point needs other endpoint of {user_id} to work
  static const String verifyEmail = '$userEndPoint/email_verify';
  static const String resendEmailVerify = '$userEndPoint/email_verify_resend';
  static const String resetPassword = '$userEndPoint/password_restore_reset';
  static const String forgotPassword = '$userEndPoint/password_restore_send';

  static const String userProfile = '$userEndPoint/profile';
  static const String login = '$userEndPoint/login';
  static const String logout = '$userEndPoint/logout';

  ///Membership cards
  static const String cardEndPoint = '$baseUrl/api/v1/member';
  static const String checkCard = '$cardEndPoint/card';
  static const String claimCard = '$cardEndPoint/claim_card';
  static const String makeCard = '$cardEndPoint/make_card';
  static const String qrCode = '$cardEndPoint/qr_code';

  ////location: countries end points
  static const String countriesEndPoints = '$baseUrl/api/v1/ref';
  static const String allCountries = '$countriesEndPoints/countries';

  ///categories: Base url is same as of $countriesEndPoints
  static const String categories = '$countriesEndPoints/shop_categories';

  ///shops end point

  static const String shops = '$baseUrl/api/v1/location/nearby';

  ///add and remove a shop from favourites: this end point required /{shop} at end

  static const String addShopToFavourite = '$baseUrl/api/v1/favorite/store/';
  static const String removeShopToFavourite =
      '$baseUrl/api/v1/favorite/destroy/';

  ///vouchers: this end point needs shop id
  static const String vouchers = '$baseUrl/api/v1/voucher/list/';

  ///stamp card apis end point:
  static const String stampCard = '$baseUrl/api/v1/stampcard';
}

///https://shoplocalclubcard.com/terms-conditions/
