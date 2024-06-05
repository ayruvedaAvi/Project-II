import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/models/userdetails_datamodel.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_postcard.dart';
import 'package:get/get.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Saral,",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                        Obx(
                          () => Text(name.value,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 188, 2, 185),
                              )),
                        ),
                      ]),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset('assets/images/profile_image.jpg'),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
                  })
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
