import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/addpost_screen.dart';
import 'package:flutter_project/screens/chats_screen.dart';
import 'package:flutter_project/screens/feed_screen.dart';
import 'package:flutter_project/screens/userprofile_screen.dart';

class BaseScreen extends StatefulWidget {
  final int initalIndex;
  const BaseScreen({super.key, required this.initalIndex});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late final List<Widget> lstWidget;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initalIndex;

    lstWidget = [
      const FeedScreen(),
      const AddpostScreen(),
      const ChatsScreen(),
      const UserprofileScreen(),
    ];
  }

  // Define icon colors for each index
  List<Color> iconColors = [
    Colors.black, // Index 0: White
    Colors.black, // Index 1: White
    Colors.black, // Index 2: White
    Colors.black, // Index 3: White
    Colors.black,
  ];

  Color getButtonBackgroundColor(int index) {
    switch (index) {
      case 0:
        return const Color.fromARGB(255, 248, 152, 9);
      case 1:
        return const Color.fromARGB(255, 248, 152, 9);
      case 2:
        return const Color.fromARGB(255, 248, 152, 9);
      case 3:
        return const Color.fromARGB(255, 248, 152, 9);
      case 4:
        return const Color.fromARGB(255, 248, 152, 9);
      default:
        return const Color.fromARGB(255, 248, 152, 9); // Default color
    }
  }

  // Update icon colors based on the selected index
  void updateIconColors() {
    for (int i = 0; i < iconColors.length; i++) {
      if (i == _selectedIndex) {
        // Selected index, set icon color to black
        iconColors[i] = Colors.black;
      } else {
        // Unselected index, set icon color to white
        iconColors[i] = Colors.black;
      }
    }
  }

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit app?'),
        content: const Text('Do you want to exit from the app?'),
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
    ).then(
        (value) => value ?? false); // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: Center(
          child: lstWidget[_selectedIndex],
        ),
        bottomNavigationBar: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CurvedNavigationBar(
            index: widget.initalIndex,
            key: const ValueKey('bottomNav'),
            height: 55,
            backgroundColor: Colors.white,
            color: Colors.black26,
            animationDuration: const Duration(milliseconds: 300),
            buttonBackgroundColor: getButtonBackgroundColor(_selectedIndex),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                updateIconColors(); // Update icon colors
              });
            },
            items: [
              GetIcon(
                icon: Icons.home,
                color: iconColors[0],
                size: 20,
              ),
              GetIcon(
                icon: Icons.add,
                color: iconColors[1],
                size: 20,
              ),
              GetIcon(
                icon: Icons.message,
                color: iconColors[2],
                size: 20,
              ),
              GetIcon(
                icon: Icons.person,
                color: iconColors[3],
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
        size: 20,
      ),
    );
  }
}
