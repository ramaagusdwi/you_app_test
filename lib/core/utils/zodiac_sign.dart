String getZodiacSign(DateTime birthdate) {
  const List<String> signNames = [
    "Capricorn",
    "Aquarius",
    "Pisces",
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn"
  ];
  const List<int> signDays = [0, 22, 20, 21, 21, 22, 23, 23, 23, 23, 23, 22, 22];

  if (birthdate.day < signDays[birthdate.month])
    return signNames[birthdate.month - 1];
  else
    return signNames[birthdate.month];
}

String calculateChineseZodiac(int year) {
  List<String> zodiacs = [
    'Monkey',
    'Rooster',
    'Dog',
    'Pig',
    'Rat',
    'Ox',
    'Tiger',
    'Rabbit',
    'Dragon',
    'Snake',
    'Horse',
    'Sheep'
  ];

  return zodiacs[(year - 1900) % 12];
}
