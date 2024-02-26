// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:subhash_app/dashboard.dart';
import 'package:subhash_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null)
          ? Dashboard()
          : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorname;

  bool passwordVisible = false;
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  void LoginFuntion() async {
    String Email = emailController.text.trim();
    String Password = passwordController.text.trim();
    if (Email == "" || Password == "") {
      String error = "Filed not be empty";
      showerror(error);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: Email, password: Password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        }
      } on FirebaseAuthException catch (excpetion) {
        print(excpetion.code.toString());
        switch (excpetion.code) {
          case "invalid-credential":
            showerror(excpetion.code);
            break;
          case "invalid-email":
            showerror(excpetion.code);
            break;
          case "invalid-credential":
            showerror(excpetion.code);
            break;
          case "invalid-email":
            showerror(excpetion.code);
            break;
          default:
            print("Unknown error.");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/stationery.png"),
                        opacity: 0.7,
                        alignment: Alignment.topRight,
                        fit: BoxFit.cover)),
                child: Text(
                  "Statinory essentinal",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              })),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          LoginFuntion();
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      Text("                  "),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showerror(String errortype) {
    errorname = errortype;
    final snackBar = SnackBar(
      content: Text("$errorname"),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
