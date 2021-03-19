import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void ShowToast(String text, BuildContext context) =>
    Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
