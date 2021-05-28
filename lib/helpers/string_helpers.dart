RegExp _emailRegex = RegExp(
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

class StringHelpers {
  static String formatDate(DateTime time) {
    return "${time.day}/${time.month}/${time.year}";
  }

  static int dateDiff(DateTime date1, DateTime date2) {
    return date2.day - date1.day;
  }

  /// Check if string [input] is an email
  static bool isEmail(String input) {
    if (input == null) {
      return false;
    }
    if (input.toString().length > 254) {
      return false;
    }
    var valid = _emailRegex.hasMatch(input);
    if (!valid) {
      return false;
    }

    var parts = input.toString().split('@');
    if (parts[0].length > 64) {
      return false;
    }

    var domainParts = parts[1].split(".");
    if (domainParts.every((part) => part.length > 63)) {
      return false;
    }

    return true;
  }
}
