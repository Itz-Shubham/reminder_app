String guessTaskTypeByTitle(String text) {
  String lowerCaseTask = text.toLowerCase();

  Map<String, List<String>> routineTypes = {
    'WakeUp': ['wake', 'moring'],
    'Breakfast': ['breakfast'],
    'Lunch': ['lunch', 'eat'],
    'Meeting': ['meeting', 'work'],
    'Nap': ['nap', 'relax'],
    'Sleep': ['sleep'],
    'Sports': ['sport'],
    'Study': ['study', 'reading', 'library'],
    'Gym': ['gym', 'excercise'],
  };

  for (var entry in routineTypes.entries) {
    if (entry.value.any((keyword) => lowerCaseTask.contains(keyword))) {
      return entry.key;
    }
  }

  return 'Unknown';
}
