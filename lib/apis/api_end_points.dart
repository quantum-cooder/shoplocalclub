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

  ///check in & check out. it needs location id at end
  static const String checkInShopLocation =
      '$baseUrl/api/v1/location/check_in/';
  static const String checkOutShopLocation =
      '$baseUrl/api/v1/location/check_out/';

  ///categories: Base url is same as of $countriesEndPoints
  static const String categories = '$countriesEndPoints/shop_categories';

  ///shops end point
  ///### 4.1 List Shops of users that they own
  static const String shops = '$baseUrl/api/v1/shop/';

  ///shops nearby you
  static const String nearByShops = '$baseUrl/api/v1/location/nearby';

  // Retrieve details of a specific location, it needs shop location id at end of url
  static const String getSpecificShop = '$baseUrl/api/v1/location/show/';

  ///### 5.5 Get Clients Check-Ins

// Retrieve check-ins for clients at a specific location.

// **POST** `/api/v1/location/clients_check_ins/{location_id}`
  static const String hasCheckedInSpecificShop =
      '$baseUrl/api/v1/location/clients_check_ins/';

////operate user profile data
  static const String specificShopOperatorUserData =
      '$baseUrl/api/v1/member/user';

  ///add and remove a shop from favourites: this end point requires /{shop} or shop id at end
  static const String addShopToFavourite = '$baseUrl/api/v1/favorite/store/';

  ///shop id at end only
  static const String removeShopToFavourite =
      '$baseUrl/api/v1/favorite/unlike/';

  ///vouchers: logged in users vouchers
  static const String mineVouchers = '$baseUrl/api/v1/voucher/mine';
  static const String archivedVouchers = '$baseUrl/api/v1/voucher/mine/archive';

  ///stamp card apis end point:
  // all stamp cards for logged in users
  static const String userStampCards = '$baseUrl/api/v1/stampcard';
  static const String userStampCardsArchived =
      '$baseUrl/api/v1/stampcard/archive';

  ///processing cards OR shop processing //6.4 Get shops that user can operate
  static const String shopsOperatedByUser = '$baseUrl/api/v1/operator';
//6.5 Set user as active operator at the location || this need location_id at end of url
  static const String operateShop = '$baseUrl/api/v1/operator/operate/';
}

///https://shoplocalclubcard.com/terms-conditions/
