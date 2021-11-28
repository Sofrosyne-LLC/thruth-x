class Utils {
  static List<String> generateRange(int start, int size) {
    return List.generate(size, (index) => index)
        .map((e) => (start + e).toString())
        .toList();
  }
}
