import 'package:flutter/material.dart';

class CustomOtheruserBottomsheet extends StatefulWidget {
  const CustomOtheruserBottomsheet({super.key});

  @override
  State<CustomOtheruserBottomsheet> createState() =>
      _CustomOtheruserBottomsheetState();
}

class _CustomOtheruserBottomsheetState
    extends State<CustomOtheruserBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Add to favorite',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.report,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Report post',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Share',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   leading: const Icon(
                  //     Icons.change_circle_outlined,
                  //     color: Colors.black,
                  //   ),
                  //   title: const Text(
                  //     'Change Status',
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.more_vert),
      color: Colors.black,
    );
  }
}
