import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

extension HeightExtension on double {
  double get ofHeight => MediaQuery.of(context).size.height * this;

  double get ofWidth => MediaQuery.of(context).size.width * this;
}

BuildContext get context {
  BuildContext? ctx = Get.context;
  if (ctx == null) throw "couldn't find context";
  return ctx;
}
