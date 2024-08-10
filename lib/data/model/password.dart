class Password {
  final String value;
  final bool isValid;

  const Password.pure()
      : value = '',
        isValid = false;
  Password.dirty(this.value) : isValid = _isValid(value);

  static bool _isValid(String value) {
    return value.length >= 6;
  }
}
