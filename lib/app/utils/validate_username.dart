String? validateUsername(String username) {
  final usernameRegex = RegExp(r'^[a-zA-Z0-9]{3,20}$');
  if (username.isEmpty) {
    return 'Username is required';
  } else if (!usernameRegex.hasMatch(username)) {
    return 'Enter a valid username (3-20 alphanumeric characters)';
  }
  return null;
}
