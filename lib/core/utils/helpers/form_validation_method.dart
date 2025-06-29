class FormValidationMethod {
  static String? validateEmailAndPhoneNum(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or phone number is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^\+?(971|20)[0-9]{7,}$');

    if (!emailRegex.hasMatch(value.trim()) &&
        !phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid email or phone number';
    }

    return null;
  }

  static String? validateNameField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    final hasLetter = value.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));

    if (!hasLetter || !hasNumber) {
      return 'Password must contain letters and numbers';
    }

    return null;
  }

  static String? validateRepassword(value, passwordController) {
    if (value == null || value.trim().isEmpty) {
      return 'Please re-enter your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final trimmed = value.trim();
    final phoneRegex = RegExp(r'^[0-9]{7,}$');
    if (!phoneRegex.hasMatch(trimmed)) {
      return 'Enter a valid phone number (digits only, no "+" or spaces)';
    }

    return null;
  }
}
