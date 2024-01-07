String guessTaskAssetIconByTaskType(String type) {
  String assetIconPath = 'assets/icons';
  switch (type) {
    case 'WakeUp':
      return '$assetIconPath/morning.png';
    case 'Breakfast':
      return '$assetIconPath/breakfast.png';
    case 'Lunch':
      return '$assetIconPath/lunch.png';
    case 'Meeting':
      return '$assetIconPath/meeting.png';
    case 'Nap':
      return '$assetIconPath/nap.png';
    case 'Sleep':
      return '$assetIconPath/sleep.png';
    case 'Sports':
      return '$assetIconPath/sports.png';
    case 'Study':
      return '$assetIconPath/studying.png';
    case 'Gym':
      return '$assetIconPath/gym.png';
    // case 'Running':
    //   return '$assetIconPath/running.png';
    default:
      return '$assetIconPath/reminder.png';
  }
}
