class Email {
  final String value;
  final bool isValid;

  const Email.pure()
      : value = '',
        isValid = false;
  Email.dirty(this.value) : isValid = _isValid(value);

  static bool _isValid(String value) {
    return value.contains('@');
  }
}
