extension StringHelpers on String {
  String capitalize() {
    if (this == null) return null;

    if (length <= 1) return this;

    return this[0].toUpperCase() + substring(1);
  }

  String last(int n) {
    if (n >= length) return this;

    return substring(length - n, length);
  }
}
