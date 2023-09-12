void cl(dynamic message, {int level = 1}) {
  var a = StackTrace.current;
  final regexCodeLine = RegExp(r" (\(.*\))$");

  print(
      "$message${regexCodeLine.stringMatch(a.toString().split("\n")[level])}");
}
