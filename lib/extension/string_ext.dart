extension StringExtension on String? {
  bool get checkIsEmpty {
    if (this == '' || this == null || this == 'null') {
      return true;
    } else {
      return false;
    }
  }
}
