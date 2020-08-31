import 'package:build/build.dart';
import 'package:flutter_gen/src/generators/generator.dart';
import 'package:flutter_gen/src/settings/flutter/flutter_fonts.dart';
import 'package:flutter_gen/src/utils/camel_case.dart';
import 'package:yaml/yaml.dart';

class FontsGenerator {
  static String generate(FlutterFonts flutterFonts) {
    if (flutterFonts == null) {
      throw InvalidInputException;
    }

    final buffer = StringBuffer();
    buffer.writeln(header());
    buffer.writeln();
    buffer.writeln('class FontFamily {');
    buffer.writeln('  FontFamily._();');
    buffer.writeln();

    flutterFonts.fonts
        .cast<YamlMap>()
        .map((element) => element['family'] as String)
        .forEach((family) {
      buffer
          .writeln("  static const String ${camelCase(family)} = \'$family\';");
    });

    buffer.writeln('}');
    return buffer.toString();
  }
}
