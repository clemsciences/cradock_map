class CradockOriginalBook {
  final String title;
  final String subtitle;
  final String publisher;
  final String publicationLocation;
  final int year;
  final String url;

  CradockOriginalBook(
      {required this.title,
      required this.subtitle,
      required this.publisher,
      required this.publicationLocation,
      required this.year,
      required this.url});
}

class CradockOriginalBookPage {
  final String text;
  final int page;

  CradockOriginalBookPage({required this.text, required this.page});
}
