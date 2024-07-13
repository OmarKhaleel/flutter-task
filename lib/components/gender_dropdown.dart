import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  final String? hintText;
  final String? selectedGender;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? errorMsg;

  const GenderDropdown({
    super.key,
    this.hintText = 'Select Gender',
    this.selectedGender,
    this.onChanged,
    this.validator,
    this.errorMsg,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      validator: widget.validator,
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: widget.errorMsg,
      ),
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
