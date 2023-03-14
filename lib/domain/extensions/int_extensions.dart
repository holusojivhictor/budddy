extension IntExtensions on int {
  bool validLength(int other) {
    return compareTo(other).isNegative ? false : true;
  }
}
