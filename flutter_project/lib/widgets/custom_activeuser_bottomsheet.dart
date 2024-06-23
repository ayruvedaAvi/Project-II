import 'package:flutter/material.dart';

class CustomActiveuserBottomsheet extends StatefulWidget {
  const CustomActiveuserBottomsheet({super.key});

  @override
  State<CustomActiveuserBottomsheet> createState() =>
      _CustomActiveuserBottomsheetState();
}

class _CustomActiveuserBottomsheetState
    extends State<CustomActiveuserBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Delete',
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
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.change_circle_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Change Status',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
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
