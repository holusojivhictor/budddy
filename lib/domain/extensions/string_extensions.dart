extension StringExtensions on String? {
  bool get isNullEmptyOrWhitespace => this == null || this!.isEmpty || this!.trim().isEmpty;
  bool get isNotNullEmptyOrWhitespace => !isNullEmptyOrWhitespace;

  bool get isNullEmptyOrWhitespaceOrHasNull => this == null || this!.isEmpty || this!.contains('null');
  bool get isNotNullEmptyOrWhitespaceNorHasNull => !isNullEmptyOrWhitespaceOrHasNull;

  String get displayName => capitalize('$this'.split('@').first);
}

String capitalize(String input) {
  return "${input[0].toUpperCase()}${input.substring(1).toLowerCase()}";
}
