import 'package:flutter/services.dart';

class RemoveLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.startsWith('0') && text.length > 1 && text[1] != '.' && text[1] != ',') {
      final newText = text.substring(1);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newValue.selection.end - 1),
      );
    }
    
    return newValue;
  }
}