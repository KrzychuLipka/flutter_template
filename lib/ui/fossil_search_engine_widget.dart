import 'package:flutter/material.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/data/repository/dto/fossil_dto.dart';

class FossilSearchEngineWidget extends StatefulWidget {
  final List<FossilDto> fossils;
  final Function(FossilDto) itemClickCallback;
  final Function? itemNotFoundCallback;

  const FossilSearchEngineWidget({
    super.key,
    required this.fossils,
    required this.itemClickCallback,
    this.itemNotFoundCallback,
  });

  @override
  State<FossilSearchEngineWidget> createState() => _FossilSearchEngineState();
}

class _FossilSearchEngineState extends State<FossilSearchEngineWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  List<FossilDto> _filteredFossils = [];

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
            _filteredFossils.clear();
          } else {
            _filteredFossils = widget.fossils
                .where((searchItem) => searchItem.findDescription
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
      onPressed: () => _clear(),
      icon: const Icon(Icons.clear),
    );
  }

  Widget _getResultsWidget(
    BuildContext context,
  ) {
    if (_filteredFossils.isEmpty) return const SizedBox();
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
          itemCount: _filteredFossils.length,
          itemBuilder: (context, index) {
            final searchItem = _filteredFossils[index];
            return ListTile(
              title: Text(searchItem.findDescription),
              subtitle: Text(searchItem.geologicalPeriod),
              onTap: () {
                widget.itemClickCallback(searchItem);
                _clear();
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

  void _clear() {
    FocusScope.of(context).unfocus();
    _textEditingController.clear();
    setState(() {
      _filteredFossils.clear();
    });
  }

  void _submit(
    String value,
  ) {
    final itemsFound =
        _filteredFossils.where((item) => item.findDescription == value);
    if (itemsFound.isEmpty) {
      widget.itemNotFoundCallback?.call();
    } else {
      widget.itemClickCallback(itemsFound.first);
      _clear();
    }
  }
}
