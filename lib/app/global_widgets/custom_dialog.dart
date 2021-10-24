import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.child,
    this.showPadding = true,
  }) : super(key: key);

  final Widget child;
  final bool showPadding;

  @override
  Widget build(BuildContext context) {
    var _child = child;

    if (showPadding) {
      _child = Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: child,
      );
    } else {
      _child = Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
        child: child,
      );
    }

    return Dialog(
      elevation: 8.0,
      insetAnimationCurve: Curves.easeInOut,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: _child,
    );
  }
}
