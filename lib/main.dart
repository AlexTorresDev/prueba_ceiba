import 'package:flutter/material.dart';

import 'package:prueba_ceiba/injection.dart' as di;
import 'package:prueba_ceiba/presentation/my_app.dart';

void main() {
  di.init();
  runApp(MyApp());
}
