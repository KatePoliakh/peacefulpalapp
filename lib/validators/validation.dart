String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Enter email';
  if (!value.contains('@') || !value.contains('.')) {
    return 'Enter a valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Enter password';
  if (value.length < 6) return 'At least 6 characters';
  return null;
}
