class StringUtil {
  StringUtil._();

  static String formattedPhone(String phone) {
    return phone.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3,4})(\d{4})'), (m) => '${m[1]}-${m[2]}-${m[3]}');
  }
}
