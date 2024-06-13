import 'package:flutter/material.dart';

class SinglepostScreen extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  final String? title;
  final double? price;
  final String? createdAt;
  const SinglepostScreen(
      {super.key,
      this.workDescription,
      this.image,
      this.profileImg,
      this.userName,
      this.title,
      this.price,
      this.createdAt});

  @override
  State<SinglepostScreen> createState() => _SinglepostScreenState();
}

class _SinglepostScreenState extends State<SinglepostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Post",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            // margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(widget.profileImg.toString()),
                      radius: 40,
                    ),
                    title: Text(
                      widget.userName.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      widget.createdAt.toString(),
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Text(
                    widget.title.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 6),
                  child: Text(
                    widget.workDescription.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Image.network(
                      widget.image.toString(),
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                              "Image for this job was corrupted or not found!"),
                        );
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Text(
                    widget.price.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 168, 105, 227),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Accept",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 168, 105, 227)),
                          foregroundColor:
                              const Color.fromARGB(255, 168, 105, 227),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Chat",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }
}
