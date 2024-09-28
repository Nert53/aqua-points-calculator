String convertMonthShortcutToName(String monthShort) {
  switch (monthShort) {
    case 'Jan':
      return 'January';
    case 'Feb':
      return 'February';
    case 'Mar':
      return 'March';
    case 'Apr':
      return 'April';
    case 'May':
      return 'May';
    case 'Jun':
      return 'June';
    case 'Jul':
      return 'July';
    case 'Aug':
      return 'August';
    case 'Sep':
      return 'September';
    case 'Oct':
      return 'October';
    case 'Nov':
      return 'November';
    case 'Dec':
      return 'December';
    default:
      return 'Invalid month';
  }
}

int convertMontToInt(String monthShort) {
  switch (monthShort) {
    case 'Jan':
      return 1;
    case 'Feb':
      return 2;
    case 'Mar':
      return 3;
    case 'Apr':
      return 4;
    case 'May':
      return 5;
    case 'Jun':
      return 6;
    case 'Jul':
      return 7;
    case 'Aug':
      return 8;
    case 'Sep':
      return 9;
    case 'Oct':
      return 10;
    case 'Nov':
      return 11;
    case 'Dec':
      return 12;
    default:
      return 1;
  }
}
