import 'package:flutter/material.dart';

class DropdownFormField extends StatefulWidget {
  final String? initialValue;
  final List<String> items;
  final void Function(String?) onChanged;

  DropdownFormField({
    required this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  _DropdownFormFieldState createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends State<DropdownFormField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
