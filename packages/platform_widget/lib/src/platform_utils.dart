enum platformType {
  material,
  cupertino,
}

String castEnumToString(
  String string,
) =>
    string
        .toString()
        .split(
          '.',
        )
        .last;

extension ParseToStringPlatform on platformType {
  String toShortString() {
    final that = this;
    return castEnumToString(
      that.toString(),
    );
  }
}

extension ParseToPlatformFromString on String {
  platformType toUpdateplatformType() {
    final that = this;
    return platformType.values.firstWhere(
      (e) => e.toShortString() == that.toString(),
      orElse: () => platformType.material,
    );
  }
}
