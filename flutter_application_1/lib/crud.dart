import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  @override
  final add1 = TextEditingController();
  final add2 = TextEditingController();
  final add3 = TextEditingController();
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("user");
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase"),
        ),
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Center(
                  child: Text("Input Data"),
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: add1,
                        autofocus: true,
                        decoration:
                            InputDecoration(hintText: "Input your name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input your Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: add2,
                        autofocus: true,
                        decoration:
                            InputDecoration(hintText: "Input your email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input Your Email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: add3,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Input your gender",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input your Gender';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        users.add({
                          "nama": add1.text,
                          "email": add2.text,
                          "gender": add3.text,
                          // "password": ""
                        });
                        add1.clear();
                        add2.clear();
                        add3.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
