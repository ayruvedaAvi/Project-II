
import 'package:flutter/material.dart';

import '../../utils/shared_preferences/shared_preference.dart';

String? getRole() {
  String? role;
  () async {
    role = await UserSharedPreference.getStringDataFromStorage("role");
  };
  return role;
}

Color getJobTypeColor(String? jobType) {
    final List<Map<String, dynamic>> jobTypeCategories = [
      {'name': 'Technical', 'color': Colors.red},
      {'name': 'Household', 'color': Colors.blue},
      {'name': 'Repair', 'color': Colors.green},
      {'name': 'Construction', 'color': Colors.teal},
      {'name': 'Cleaning', 'color': Colors.purple},
      {'name': 'Gardening', 'color': Colors.orange},
      {'name': 'Cooking', 'color': Colors.indigo},
      {'name': 'Shifting Service', 'color': Colors.brown},
      {'name': 'Others', 'color': Colors.pink},
    ];

    var matchedCategory = jobTypeCategories.firstWhere(
        (category) => category['name'] == jobType,
        orElse: () => {'color': Colors.grey}); // Default color if no match
    return matchedCategory['color'];
  }
