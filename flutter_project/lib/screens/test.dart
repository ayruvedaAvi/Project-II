import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/models/userdetails_datamodel.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_postcard.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  RxString name = ''.obs;

  Future<void> getName() async {
    name.value = await UserSharedPreference.getStringDataFromStorage('name') ??
        'Error fetching name';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 24, 224, 198),
      //   title: const Text("Welcome to Saral!"),
      //   centerTitle: true,
      //   titleTextStyle:
      //       const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
      // ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Saral, We Connect!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 143, 69, 211)),
                      ),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/images/profile_image.jpg'),
                      )
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                  future: readJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<UserDetailsDataModel>;
                      return SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CustomPostcard(
                                profileImg: items[index].profileImg,
                                userName: items[index].userName,
                                workDescription: items[index].workDescription,
                                image: items[index].image,
                              );
                            },
                            itemCount: items.length,
                          ));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<UserDetailsDataModel>> readJsonData() async {
    final jsonData =
        await rootBundle.loadString('assets/jsonFile/userdetails.json');
    final list = jsonDecode(jsonData) as List<dynamic>;

    return list.map((e) => UserDetailsDataModel.fromJson(e)).toList();
  }
}
