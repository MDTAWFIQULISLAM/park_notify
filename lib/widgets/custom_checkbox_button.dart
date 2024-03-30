import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color checkColor;

  const CustomCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value);
        }
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.value ? widget.activeColor : Colors.transparent,
          border: Border.all(color: widget.activeColor),
        ),
        child: widget.value
            ? Icon(Icons.check, size: 16, color: widget.checkColor)
            : null,
      ),
    );
  }
}
