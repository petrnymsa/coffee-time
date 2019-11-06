import 'package:coffee_time/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

void main() async {
  await initializeDateFormatting('cs');
  await initializeDateFormatting('en');

  Intl.defaultLocale = await findSystemLocale();

  runApp(App());
}
