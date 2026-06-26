String interpolateLocalization({
  required String text,
  Map<String, dynamic>? replacements,
}) {
  if (replacements == null || replacements.isEmpty) {
    return text;
  }

  String result = text;
  replacements.forEach((key, value) {
    result = result.replaceAll('{$key}', value.toString());
  });
  return result;
}
