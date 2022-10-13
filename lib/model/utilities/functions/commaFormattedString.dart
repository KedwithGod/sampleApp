// function to format a number with comma
displayWithComma(String value){
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  String result = value.replaceAllMapped(reg, mathFunc);
 /* print('$value -> $result');*/
  return result;
}