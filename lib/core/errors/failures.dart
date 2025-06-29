abstract class Failure {
  String get msg;
}

class OfflineFailure implements Failure {
  @override
  String get msg => 'No internet connection. Please check your network.';
}

class ServerFailure implements Failure {
  @override
  String get msg => 'Server error occurred. Please try again later.';
}

class CacheFailure implements Failure {
  @override
  String get msg => 'Failed to retrieve data from cache.';
}

class LoginInvalidCredentialsFailure implements Failure {
  @override
  String get msg => 'Invalid credentials';
}

class RegisterValidationFailure implements Failure {
  @override
  String get msg => 'Please fill in all required fields correctly.';
}

class UserAlreadyExistsFailure implements Failure {
  @override
  String get msg =>
      'An account with this email or phone number already exists.';
}

class InvalidOTPFailure implements Failure {
  @override
  String get msg => 'The OTP you entered is incorrect. Please try again.';
}

class UserNotFoundFailure implements Failure {
  @override
  String get msg => 'No account found with this email or phone number.';
}
