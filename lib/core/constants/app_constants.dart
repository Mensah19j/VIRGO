import 'package:virgo/models/enums.dart';

class AppConstants {
  static const String appName = 'Virgo';
  static const String appVersion = '1.0.0';

  static const String staffRegistrationCode = 'VIRGO-STAFF-2026';

  // Default hardcoded staff account
  static const String defaultStaffEmail = 'staff@virgo.edu';
  static const String defaultStaffPassword = 'Virgo@2026';
  static const String defaultStaffName = 'Admin Staff';

  static const List<String> yearGroups = [
    'Year 7',
    'Year 8',
    'Year 9',
    'Year 10',
    'Year 11',
    'Year 12',
    'Year 13',
  ];

  static const Map<int, String> motivationEmojis = {
    1: '😞',
    2: '😕',
    3: '😐',
    4: '🙂',
    5: '😄',
  };

  static const Map<int, String> motivationLabels = {
    1: 'Very Low',
    2: 'Low',
    3: 'Okay',
    4: 'Good',
    5: 'Great',
  };

  static String getCategoryLabel(UpdateCategory category) {
    switch (category) {
      case UpdateCategory.general:
        return 'General';
      case UpdateCategory.academic:
        return 'Academic';
      case UpdateCategory.event:
        return 'Event';
      case UpdateCategory.sports:
        return 'Sports';
      case UpdateCategory.alert:
        return 'Alert';
    }
  }
}
