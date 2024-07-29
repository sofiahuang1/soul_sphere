String? validatePassword(String password) {
  final passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$');
  if (password.isEmpty) {
    return 'Password is required';
  } else if (!passwordRegex.hasMatch(password)) {
    return 'Password must be at least 6 characters, include an uppercase letter, a lowercase letter, and a number';
  }
  return null;
}
