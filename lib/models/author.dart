class Author {
  final String firstName;
  final String familyName;
  final String? biography;
  final String? bibliography;

  Author(
      {required this.firstName,
      required this.familyName,
      required this.biography,
      required this.bibliography});

  String get normalizedName => "$firstName ${familyName.toUpperCase()}";
  String get id => "$firstName-$familyName";
}
