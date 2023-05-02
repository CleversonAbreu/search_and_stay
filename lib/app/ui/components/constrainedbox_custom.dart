import 'package:flutter/material.dart';
import 'input_custom.dart';

class ConstrainedBoxCustom extends StatelessWidget {
  TextEditingController controller;
  String hint;
  final FocusNode focusNode;
  final int size;
  final VoidCallback? onTap;
  final Function(String value)? onSubmitted;
  late Icon? icon;
  late TextInputType? type;
  late String? helperText;
  bool? uppercase;
  final Function(String value)? onFocusChange;
  bool? obscurePassword;
  bool? readOnly;
  bool? enable;

  ConstrainedBoxCustom(this.controller, this.hint, this.focusNode, this.size,
      [this.onTap,
      this.onSubmitted,
      this.icon,
      this.type,
      this.helperText,
      this.uppercase,
      this.onFocusChange,
      this.obscurePassword,
      this.readOnly,
      this.enable]);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
          child: InputCustom(
              controller,
              hint,
              focusNode,
              size,
              onTap,
              null,
              icon!,
              type!,
              helperText!,
              uppercase!,
              onFocusChange,
              obscurePassword,
              readOnly,
              enable),
        ));
  }
}
