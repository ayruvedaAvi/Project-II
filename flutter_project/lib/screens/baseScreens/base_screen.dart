import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/baseScreens/addpost_screen.dart';
import 'package:flutter_project/screens/baseScreens/chats_screen.dart';
import 'package:flutter_project/screens/baseScreens/feed_screen.dart';
import 'package:flutter_project/screens/baseScreens/notifications_screen.dart';
import 'package:flutter_project/screens/userprofile_screen.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  final int initialIndex;
  const BaseScreen({super.key, required this.initialIndex});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  String? role;
  late final List<Widget> lstWidget;
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void getRole() async {
    role = await UserSharedPreference.getStringDataFromStorage("role");
    debugPrint("Role: $role");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    getRole();

    lstWidget = [
      const FeedScreen(),
      const ChatsScreen(),
      const AddpostScreen(isEdit: false),
      const NotificationsScreen(),
      const UserprofileScreen(),
    ];
  }

  // Define icon colors for each index
  List<Color> iconColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  Color getButtonBackgroundColor(int index) {
    return mainColor;
  }

  // Update icon colors based on the selected index
  void updateIconColors() {
    for (int i = 0; i < iconColors.length; i++) {
      if (i == _selectedIndex) {
        iconColors[i] = Colors.white;
      } else {
        iconColors[i] = Colors.white;
      }
    }
  }

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('exitApp'.tr),
        content: Text('wantToExit'.tr),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value ?? false); // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: Center(
          child: lstWidget[_selectedIndex],
        ),
        bottomNavigationBar: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: widget.initialIndex,
            height: 60,
            backgroundColor: Colors.white,
            color: borderButtonColor,
            animationDuration: const Duration(milliseconds: 300),
            buttonBackgroundColor: getButtonBackgroundColor(_selectedIndex),
            onTap: (index) {
              if (index == 2 && role != null && role!.toUpperCase() == "WORKER") {
                Get.snackbar(
                  "Sorry!!",
                  "You are logged in as worker and you can't post.",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                // Resetting to previous index without calling onTap again
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _bottomNavigationKey.currentState?.setPage(_selectedIndex);
                });
              } else {
                setState(() {
                  _selectedIndex = index;
                  updateIconColors(); // Update icon colors
                });
              }
            },
            items: [
              GetIcon(
                icon: Icons.home,
                color: iconColors[0],
                size: 20,
              ),
              GetIcon(
                icon: Icons.message,
                color: iconColors[1],
                size: 20,
              ),
              GetIcon(
                icon: Icons.add,
                color: iconColors[2],
                size: 20,
              ),
              GetIcon(
                icon: Icons.notifications,
                color: iconColors[3],
                size: 20,
              ),
              GetIcon(
                icon: Icons.person,
                color: iconColors[4],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const GetIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
