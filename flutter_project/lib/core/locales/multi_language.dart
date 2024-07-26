import 'package:flutter_project/core/locales/translations/base_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/custom_widgets_translation.dart';
import 'package:flutter_project/core/locales/translations/login_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/onboarding_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/post_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/register_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/role_selection_translation.dart';
import 'package:flutter_project/core/locales/translations/setting_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/singlepost_screen_translation.dart';
import 'package:flutter_project/core/locales/translations/userprofile_translation.dart';
import 'package:flutter_project/core/locales/translations/verifyotp_screen_translation.dart';
import 'package:get/get.dart';

class MultiLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          ...enUsPostScreen,
          ...enUsLoginScreen,
          ...enUsBaseScreen,
          ...enUsCustomWidgetScreen,
          ...enUsRegisterScreen,
          ...enUsRoleSelectionScreen,
          ...enUsSettingScreen,
          ...enUsSinglePostScreen,
          ...enUsUserProfileScreen,
          ...enUsVerifyOTPScreen,
          ...enUsOnBoardingScreen,
        },
        'ne_NE': {
          ...neNePostScreen,
          ...neNeLoginScreen,
          ...neNeBaseScreen,
          ...neNeCustomWidgetScreen,
          ...neNeRegisterScreen,
          ...neNeRoleSelectionScreen,
          ...neNeSettingScreen,
          ...neNeSinglePostScreen,
          ...neNeUserProfileScreen,
          ...neNeVerifyOTPScreen,
          ...neNeOnBoardingScreen,
        },
      };
}
