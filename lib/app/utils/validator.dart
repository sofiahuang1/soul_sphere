class Validators {
  static String? validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String password) {
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$');
    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (!passwordRegex.hasMatch(password)) {
      return 'Password must be at least 6 characters, include an uppercase letter, a lowercase letter, and a number';
    }
    return null;
  }
}
