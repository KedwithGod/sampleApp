// function to remove html tag from a text
String removeHtmlTag(String text){
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  String parsedString = text.replaceAll(exp, '');
  return parsedString;
}