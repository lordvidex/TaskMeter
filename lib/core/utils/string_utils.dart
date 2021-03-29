class StringUtils {
  /// Returns null if string is properly formatter
  /// otherwise error string
  static const _MINIMUM_PASSWORD_LENGTH = 6;
  static formatMail(String s) => RegExp(r".+@.+\..+").hasMatch(s)
      ? null
      : 'Invalid Email, please check again';
  
  /// Returns null if password length is longer or equal to [_MINIMUM_PASSWORD_LENGTH]
  /// otherwise error string
  static formatPassword(String s) => s.trim().length >= _MINIMUM_PASSWORD_LENGTH
      ? null
      : 'Password length must be greater than 5';
}
