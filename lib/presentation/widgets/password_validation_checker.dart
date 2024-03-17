bool passwordIsValid(String? value) {
  bool valid = true;

  if ((value?.length ?? 0) < 8) {
    return false;
  }

  bool letterPresent = false, numberPresent = false;

  for (int i = 0; i < value!.length; i++) {
    if ((value.codeUnitAt(i) >= 'a'.codeUnitAt(0) &&
            value.codeUnitAt(i) <= 'z'.codeUnitAt(0)) ||
        (value.codeUnitAt(i) >= 'A'.codeUnitAt(0) &&
            value.codeUnitAt(i) <= 'Z'.codeUnitAt(0))) {
      letterPresent = true;
    }
    if ((value.codeUnitAt(i) >= '0'.codeUnitAt(0) &&
        value.codeUnitAt(i) <= '9'.codeUnitAt(0))) {
      numberPresent = true;
    }
  }

  if (!letterPresent || !numberPresent) {
    valid = false;
  }

  return valid;
}
