import 'package:flutter/material.dart';
import 'package:geo_app/common/dimens.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> data;
  final Function(String) valueChangeCallback;

  const DropdownWidget({
    super.key,
    required this.data,
    required this.valueChangeCallback,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.data.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: Dimens.elevationStandard,
      style: const TextStyle(
        color: Colors.black,
        fontSize: Dimens.fontSizeSmall,
      ),
      onChanged: (String? value) {
        widget.valueChangeCallback(value ?? '');
        setState(() {
          _selectedValue = value ?? '';
        });
      },
      items: widget.data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
