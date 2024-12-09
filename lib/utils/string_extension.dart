extension StringCleaner on String {
  String cleanName({List<String>? removeTags}) {
    // Default tags to remove
    List<String> tags =
        removeTags ?? ['<p>', '</p>', '<b>', '</b>', '<br/>', '<br>'];

    String result = this;
    for (var tag in tags) {
      result = result.replaceAll(tag, '');
    }

    // Remove any other remaining HTML tags using a regex
    // result = result.replaceAll(
    //     RegExp(r'<[^>]*>'), '');

    return result.trim();
  }
}
