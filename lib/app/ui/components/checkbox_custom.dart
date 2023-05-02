import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  ValueNotifier<bool>? isChecked;
  final Function(bool? value) toCheck;
  bool readOnly;
  CheckboxCustom(this.isChecked, this.toCheck,this.readOnly);
  @override
  _CheckboxCustomState createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(days: 0), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: widget.isChecked!.value,
                onChanged: widget.readOnly==false?
                    (bool? value) {
                  widget.toCheck(value);
                } : null
              ),
              const Text('Active'),
            ],
          );
        });
  }
}
