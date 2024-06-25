class NumberRepository {
  Stream<int> getNumberStream() {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) {
        return x;
      },
    ).take(10);
  }
}
