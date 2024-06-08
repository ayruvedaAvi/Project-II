import 'package:flutter_project/core/locales/translations/post_screen_translation.dart';
import 'package:get/get.dart';

class MultiLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          ...enUsPostScreen,
        },
        'ne_NE': {
          ...neNePostScreen,
        },
      };
}
