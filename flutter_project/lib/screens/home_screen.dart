import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var x = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 224, 198),
        title: const Text("Project-II"),
      ),
      backgroundColor: const Color.fromARGB(255, 62, 87, 99),
      body: Column(
        children: [
          const Center(
            child: Hero(
              tag: 'text',
              child: Text(
                "Lets start from here.",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          TextButton(onPressed: (){
            setState(() {
              x=x+1;
            });
            print(x);
          }, child: Text("increase", style: TextStyle(fontSize: 20),)),
          const SizedBox(height: 20,),
          Text(x.toString(),  style: TextStyle(fontSize: 50)),

        ],
      ),
    );
  }
}
