import 'package:flutter/material.dart';
import 'circular_progress_custom.dart';

class Footer extends StatefulWidget {
  final Function(BuildContext context) onTap;
  String? text;
  Color? colorText;
  Color? colorButton;
  ValueNotifier<bool>? isLoading;
  BuildContext? context;
  Footer(this.onTap,
      [this.text,
      this.colorText,
      this.colorButton,
      this.isLoading,
      this.context]);
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> with TickerProviderStateMixin {
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
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
      child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return GestureDetector(
                  onTap: () {
                    widget.onTap(context);
                  },
                  child: widget.isLoading!.value == true
                      ? ShowCircularProgress(widget.isLoading!.value)
                      : Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: widget.colorButton ??
                                  Colors.deepOrangeAccent),
                          child: Center(
                            child: Text(
                              widget.text ?? 'Enviar',
                              style: TextStyle(
                                  color: widget.colorText ?? Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                );
              })),
    );
  }
}
