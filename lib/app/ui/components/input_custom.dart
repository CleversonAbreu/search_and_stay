import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final FocusNode focusNode;
  final int size;
  final VoidCallback? onTap;
  final Function(String value)? onSubmitted;
  final Icon? icon;
  final TextInputType? type;
  final String? helperText;
  bool? uppercase;
  Function(String value)? onFocusChange;
  bool? obscurePassword;
  bool? readOnly;
  bool? enabled;
  InputCustom(this.controller, this.hint, this.focusNode, this.size,
      [this.onTap,
      this.onSubmitted,
      this.icon,
      this.type,
      this.helperText,
      this.uppercase,
      this.onFocusChange,
      this.obscurePassword,
      this.readOnly,
      this.enabled]);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Focus(
          child: TextField(
            keyboardType: type ?? TextInputType.text,
            onChanged: (value) {
              if (uppercase != null && uppercase == true) {
                controller.value = TextEditingValue(
                    text: value.toUpperCase(), selection: controller.selection);
              } else {
                controller.value = TextEditingValue(
                    text: value, selection: controller.selection);
              }
            },
            controller: controller,
            //readOnly: readOnly!,
            focusNode: focusNode,
            enabled: enabled,
            maxLength: size != 0 ? size : null,
            onSubmitted: onSubmitted,
            // obscureText: obscurePassword!,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
              labelText: hint,
              helperText: helperText == null ? '' : helperText,
              helperStyle: helperText == null
                  ? const TextStyle(color: Colors.grey)
                  : const TextStyle(color: Colors.red),
              prefixIcon: GestureDetector(
                  onTap: onTap,
                  child: icon == null
                      ? const Icon(
                          Icons.camera_alt,
                          color: Colors.black54,
                          size: 40,
                        )
                      : icon),
            ),
          ),
          onFocusChange: (hasFocus) {
            if (hasFocus) {
            } else {
              if (onFocusChange != null) {
                onFocusChange!(controller.text);
              }
            }
          },
        ));
  }
}
