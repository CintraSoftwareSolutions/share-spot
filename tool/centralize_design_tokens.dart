import 'dart:io';

const _colorImport = "import 'package:sharespot/core/theme/app_colors.dart';";
const _textImport =
    "import 'package:sharespot/core/theme/app_text_styles.dart';";

const _semanticColors = <String, String>{
  'FF101114': 'background',
  'FF191B20': 'surface',
  'FF1A1B20': 'surfaceElevated',
  'FF111318': 'surfaceDeep',
  'FF101217': 'circleSurface',
  'FF333333': 'borderStrong',
  'FF33363C': 'borderDialog',
  'FF2A2C31': 'authBorder',
  'FFD9D9D9': 'textSecondary',
  'FFB4B5BA': 'textMuted',
  'FFD0D1D5': 'textSoft',
  'FFBFC1C6': 'textTertiary',
  'FFC7C8CC': 'iconMuted',
  'FFC8C9CD': 'iconLight',
  'FF9A9EA8': 'iconSubtle',
  'FF071109': 'buttonInk',
  'FF003A05': 'greenInk',
  'FFFF2454': 'error',
  'FF80F17D': 'loginGreen',
  'FF907EF2': 'authLink',
};

const _namedColors = <String, String>{
  'Colors.transparent': 'AppColors.transparent',
  'Colors.white70': 'AppColors.white70',
  'Colors.white54': 'AppColors.white54',
  'Colors.black45': 'AppColors.black45',
  'Colors.redAccent': 'AppColors.redAccent',
  'Colors.white': 'AppColors.white',
  'Colors.black': 'AppColors.black',
};

void main() {
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();
  final colorFile = File('lib/core/theme/app_colors.dart');
  final textFile = File('lib/core/theme/app_text_styles.dart');
  final colorPattern = RegExp(r'Color\(0x([0-9A-Fa-f]+)\)');
  final tokenPattern = RegExp(r'AppColors\.hex([0-9A-Fa-f]+)');
  final hexValues = <String>{};

  String normalizedPath(File file) =>
      file.absolute.path.replaceAll('\\', '/').toLowerCase();
  bool isSameFile(File left, File right) =>
      normalizedPath(left) == normalizedPath(right);

  for (final file in files) {
    if (isSameFile(file, colorFile)) continue;
    final source = file.readAsStringSync();
    for (final match in colorPattern.allMatches(source)) {
      final hex = match.group(1)!.toUpperCase();
      if (!_semanticColors.containsKey(hex)) hexValues.add(hex);
    }
    for (final match in tokenPattern.allMatches(source)) {
      hexValues.add(match.group(1)!.toUpperCase());
    }
  }

  var palette = colorFile.readAsStringSync();
  const startMarker = '  // GENERATED EXACT COLOR TOKENS - START';
  const endMarker = '  // GENERATED EXACT COLOR TOKENS - END';
  final oldBlock = RegExp(
    '${RegExp.escape(startMarker)}[\\s\\S]*?${RegExp.escape(endMarker)}\\n?',
  );
  palette = palette.replaceFirst(oldBlock, '');
  final sortedHex = hexValues.toList()..sort();
  final generated = StringBuffer('$startMarker\n');
  for (final hex in sortedHex) {
    generated.writeln('  static const Color hex$hex = Color(0x$hex);');
  }
  generated.writeln(endMarker);
  final closingBrace = palette.lastIndexOf('}');
  palette =
      '${palette.substring(0, closingBrace)}${generated.toString()}${palette.substring(closingBrace)}';
  colorFile.writeAsStringSync(palette);

  for (final file in files) {
    if (isSameFile(file, colorFile)) continue;
    var source = file.readAsStringSync();
    source = source.replaceAllMapped(colorPattern, (match) {
      final hex = match.group(1)!.toUpperCase();
      return 'AppColors.${_semanticColors[hex] ?? 'hex$hex'}';
    });
    for (final entry in _namedColors.entries) {
      source = source.replaceAll(
        RegExp('(?<![A-Za-z])${RegExp.escape(entry.key)}\\b'),
        entry.value,
      );
    }
    source = source.replaceAll('const AppColors.', 'AppColors.');
    if (source.contains('AppColors.') && !source.contains('app_colors.dart')) {
      source = _addImport(source, _colorImport);
    }

    if (!isSameFile(file, textFile)) {
      source = source.replaceAll(RegExp(r'\bTextStyle\('), 'AppTextStyle(');
      if (source.contains('AppTextStyle(') &&
          !source.contains('app_text_styles.dart')) {
        source = _addImport(source, _textImport);
      }
    }
    file.writeAsStringSync(source);
  }
}

String _addImport(String source, String import) {
  final materialImport = RegExp(
    r"import 'package:flutter/(?:material|widgets|cupertino)\.dart';",
  );
  final match = materialImport.firstMatch(source);
  if (match != null) {
    return source.replaceRange(match.end, match.end, '\n$import');
  }
  final firstImport = source.indexOf('import ');
  if (firstImport >= 0) {
    return source.replaceRange(firstImport, firstImport, '$import\n');
  }
  return '$import\n\n$source';
}
