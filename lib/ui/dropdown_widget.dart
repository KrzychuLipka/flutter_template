import 'package:flutter/material.dart';
import 'package:flutter_template/common/dimens.dart';

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
  String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    if (_selectedValue.trim().isEmpty) {
      _selectedValue = widget.data.first;
    }
    return DropdownButton<String>(
      value: _selectedValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: Dimens.elevationStandard,
      style:
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
      onChanged: (String? value) {
        widget.valueChangeCallback('$value');
        setState(() {
          _selectedValue = '$value';
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
