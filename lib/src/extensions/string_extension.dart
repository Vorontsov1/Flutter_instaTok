import '../res/strings.dart';

extension StrFormat on String {
  String get firstCapital {
    List<String> values = split('');
    values[0] = values[0].toUpperCase();
    return values.join();
  }

  bool get isValidEmail {
    return emailRexExp.hasMatch(this);
  }

  bool get isValidPassword {
    return passwordRexExp.hasMatch(this);
  }
}