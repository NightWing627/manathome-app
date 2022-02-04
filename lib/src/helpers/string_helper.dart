import 'package:flutter/material.dart';

String titleize(String string) =>
    string[0].toUpperCase() + string.replaceFirst(string[0], '');
