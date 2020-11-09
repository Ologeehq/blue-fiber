import 'dart:math';

class GenerateRandomString {
  static const String _chars = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  String randomString(int length) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < length; i++) {
      result += _chars[rnd.nextInt(_chars.length)];
    }
    return result;
  }
}