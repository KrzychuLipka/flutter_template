import 'package:flutter/material.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/data/model/search_item.dart';

class SearchEngineWidget extends StatefulWidget {
  final List<SearchItem> searchItems;
  final Function(SearchItem) itemClickCallback;
  final Function? itemNotFoundCallback;

  const SearchEngineWidget({
    super.key,
    required this.searchItems,
    required this.itemClickCallback,
    this.itemNotFoundCallback,
  });

  @override
  State<SearchEngineWidget> createState() => _HomePageState();
}

class _HomePageState extends State<SearchEngineWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  List<SearchItem> _filteredItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: _getTextFieldWidget(context),
        ),
        _getResultsWidget(context),
      ],
    );
  }

  Widget _getTextFieldWidget(
    BuildContext context,
  ) {
    return TextField(
      controller: _textEditingController,
      onChanged: (value) {
        setState(() {
          if (value.trim().isEmpty) {
            _filteredItems.clear();
          } else {
            _filteredItems = widget.searchItems
                .where((searchItem) => searchItem.title
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                .toList();
          }
        });
      },
      onSubmitted: (value) => _submit(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        labelText: AppLocaleUtils.of(context).translate('search_engine.hint'),
        prefixIcon: _getSearchIconWidget(),
        suffixIcon: _getClearIconWidget(),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _getSearchIconWidget() {
    return IconButton(
      onPressed: () => _submit(_textEditingController.text),
      icon: const Icon(Icons.search),
    );
  }

  Widget _getClearIconWidget() {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        _textEditingController.clear();
        setState(() {
          _filteredItems.clear();
        });
      },
      icon: const Icon(Icons.clear),
    );
  }

  Widget _getResultsWidget(
    BuildContext context,
  ) {
    if (_filteredItems.isEmpty) return const SizedBox();
    return Expanded(
      child: Card.filled(
        shape: const BeveledRectangleBorder(
          side: BorderSide(
            color: Colors.amber,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        color: Colors.white.withOpacity(0.8),
        child: ListView.builder(
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            final searchItem = _filteredItems[index];
            return ListTile(
              title: Text(searchItem.title),
              subtitle: Text(searchItem.subTitle),
              onTap: () {
                FocusScope.of(context).unfocus();
                _textEditingController.text = searchItem.title;
                widget.itemClickCallback(searchItem);
                setState(() {
                  _filteredItems.clear();
                });
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submit(
    String value,
  ) {
    final itemsFound = _filteredItems.where((item) => item.title == value);
    if (itemsFound.isEmpty) {
      widget.itemNotFoundCallback?.call();
      return;
    }
    FocusScope.of(context).unfocus();
    widget.itemClickCallback(itemsFound.first);
    setState(() {
      _filteredItems.clear();
    });
  }
}
