String? validateEmail(String email) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (email.isEmpty) {
    return 'Email is required';
  } else if (!emailRegex.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;
}
