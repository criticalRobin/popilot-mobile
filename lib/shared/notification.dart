import 'package:flutter/material.dart';
import 'package:popilot_mobile/utils/colors.dart';

class CustomNotification extends SnackBar {
  final String message;
  final String status;

  CustomNotification({super.key, required this.message, required this.status})
      : super(
            content: Text(message, style: TextStyle(color: AppColors.white)),
            backgroundColor: status == 'success'
                ? Colors.green.shade400
                : Colors.red.shade400);
}
