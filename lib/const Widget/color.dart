
import 'dart:ui';

import 'package:flutter/material.dart';

const prirmyColor=Color.fromRGBO(0, 197, 105, 1);
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
