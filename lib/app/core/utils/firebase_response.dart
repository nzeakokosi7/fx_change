import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkResponse<T> {
  bool succeed;
  T? data;
  String? error;

  NetworkResponse(this.data, {this.error}) : succeed = error == null;

  verify() {
    if (!succeed) {
      Get.snackbar('Error', error!,
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }

    return succeed;
  }
}
