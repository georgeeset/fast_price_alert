///Get String value out of a string formated map
///
///example: String bam = "{"key": "value"}"
///
///print(valueFromStrMap(bam)); // "value"
///
String valueFromStrMap(String raw) {
  var specimen = raw;
  specimen = specimen.replaceAll('{', '').replaceAll('}', '');
  var broken = specimen.split(':');
  // return {broken[0]: broken[1]};
  return broken[1];
}
