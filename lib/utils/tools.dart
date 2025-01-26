class Tools {
  static String unicodeToString(String? content) {
    if (content == null) return "";
    return content.replaceAllMapped(
      RegExp(r'\\u([0-9a-fA-F]{4})'),
      (Match m) => String.fromCharCode(int.parse(m.group(1)!, radix: 16)),
    );
  }
}
