class SearchItem {
  final String title;
  final String subTitle;
  final bool isSelected;

  SearchItem({
    required this.title,
    required this.subTitle,
    this.isSelected = false,
  });
}
