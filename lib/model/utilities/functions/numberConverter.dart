String k_m_b_generator(num number) {
  if (number > 999 && number < 99999) {
    return "${(number / 1000).round().toString()} K";
  } else if (number > 99999 && number < 999999) {
    return "${(number / 1000)..round().toString()} K";
  } else if (number > 999999 && number < 999999999) {
    return "${(number / 1000000).round().toString()} M";
  } else if (number > 999999999) {
    return "${(number / 1000000000).round().toString()} B";
  } else {
    return number.toStringAsFixed(1);
  }}