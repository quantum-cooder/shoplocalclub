class RegisterUserModel {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  int? countryId;
  String? zipCode;

  RegisterUserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.countryId,
    required this.zipCode,
  });

  static String keyName = 'name';
  static String keyEmail = 'email';
  static String keyPassword = 'password';
  static String keyConfirmPassword = 'password_confirmation';
  static String keyCountryId = 'country_id';
  static String keyZipCode = 'zipcode';

  Map<dynamic, dynamic> toMap(RegisterUserModel model) {
    return {
      keyName: name!,
      keyEmail: email!,
      keyPassword: password!,
      keyConfirmPassword: confirmPassword!,
      keyCountryId: countryId!,
      keyZipCode: zipCode!,
    };
  }
}
