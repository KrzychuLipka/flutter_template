class SearchItem {
  final String id;
  final String title;
  final String subTitle;
  final bool isSelected;

  SearchItem({
    required this.id,
    required this.title,
    required this.subTitle,
    this.isSelected = false,
  });
}
