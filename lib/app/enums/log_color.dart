import 'package:flutter/material.dart';

enum LogColor {
  verbose('Level.verbose', Colors.grey),
  debug('Level.debug', Colors.blue),
  info('Level.info', Colors.black),
  warning('Level.warning', Colors.orange),
  error('Level.error', Colors.red),
  wtf('Level.wtf', Colors.orange),
  nothing('Level.nothing', Colors.black);

  final String level;
  final Color color;
  const LogColor(this.level, this.color);
}
