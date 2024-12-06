// validators.dart

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name can\'t be empty';
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Please enter a valid name';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email can\'t be empty';
  }
  // Add a simple email regex for validation
  final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password can\'t be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? confirmPasswordValidator(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm password can\'t be empty';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? valueNotSelectedValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Value can\'t be empty';
  }
  return null;
}
