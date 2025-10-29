import 'package:flutter/material.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble()); // padding height
  SizedBox get pw => SizedBox(width: toDouble());  // padding width
}
