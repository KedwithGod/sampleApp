// class to validate phone number

class ValidatePhoneNumber{
  // function to validate phone number with +234
  bool isValidNumber(String input) {
    final RegExp regex =  RegExp(r'^(?:[+]13)?[0-9]{14}$');
    regex.hasMatch(input)?print("$input validated"):print("$input invalidated");
    return regex.hasMatch(input);
  }
  // function to validate phone number

  bool isValidPhone(String input) {
    final RegExp regex =  RegExp(r'^[0][7|8|9][0|1]\d{8}$');
    regex.hasMatch(input)?print("$input validated"):print("$input invalidated");
    return regex.hasMatch(input);
  }
}