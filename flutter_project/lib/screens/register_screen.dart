import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 224, 198),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  "Create your account",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 32.0),
                //Form
                Form(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          expands: false,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  )),
                              labelText: "First Name",
                              labelStyle: const TextStyle(color: Colors.black),
                              prefixIcon: const Icon(Icons.account_circle),
                              prefixIconColor: Color.fromARGB(255, 0, 0, 0)),
                        )),
                        const SizedBox(width: 16.0),
                        Expanded(
                            child: TextFormField(
                          expands: false,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )),
                            labelText: "Last Name",
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      expands: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          labelText: "Mobile Number",
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(Icons.local_phone_rounded),
                          suffixIconColor: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      expands: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          labelText: "Email",
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(Icons.mail),
                          suffixIconColor: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      expands: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          labelText: "Enter Password",
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(Icons.remove_red_eye),
                          suffixIconColor: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      expands: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          labelText: "Confirm Password",
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(Icons.remove_red_eye),
                          suffixIconColor: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    //Terms and condition Checkbox
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {
                                if (value == true) {
                                  value = false;
                                } else {
                                  value = true;
                                }
                              },
                            )),
                        const SizedBox(width: 16.0),
                        const Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "I agree to",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          TextSpan(
                              text: " Privacy Policy ",
                              style: TextStyle(
                                color: Colors.blue,
                              )),
                          TextSpan(
                              text: "and",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          TextSpan(
                              text: " Terms of use.",
                              style: TextStyle(
                                color: Colors.blue,
                              )),
                        ]))
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    //Sign up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 24, 224, 198),
                        ),
                        onPressed: (){
                          
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
