import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final String? selectedCountryCode;
  final void Function(String?)? onCountryCodeChanged;
  final List<Map<String, String>> countryCodes = [
    {'code': '+962', 'country': 'JO', 'flag': '🇯🇴'},
    // Add more country codes here
  ];

  PhoneNumberTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.selectedCountryCode,
    this.onCountryCodeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: selectedCountryCode ?? countryCodes.first['code'],
          items: countryCodes
              .map<DropdownMenuItem<String>>((Map<String, String> code) {
            return DropdownMenuItem<String>(
              value: code['code'],
              child: Row(
                children: [
                  Text(code['flag']!),
                  const SizedBox(width: 8),
                  Text(code['code']!),
                ],
              ),
            );
          }).toList(),
          onChanged: onCountryCodeChanged,
          underline: const SizedBox(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: TextInputType.phone,
            focusNode: focusNode,
            onChanged: onChanged,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
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
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              errorText: errorMsg,
            ),
          ),
        ),
      ],
    );
  }
}
