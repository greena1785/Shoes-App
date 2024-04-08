import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/firebaseService/firebase_service.dart';
import 'package:shoes_app/model/user.dart';
import 'package:shoes_app/ui/login_screen.dart';
import 'package:shoes_app/ui/main_screen.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  String? name;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseService _service = FirebaseService();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'heroicon',
                    child: AnimatedContainer(
                      duration: Duration(seconds: 5), // Animation duration
                      curve: Curves.easeInOut, // Animation curve
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/login.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'HerTitle',
                      child: Text(
                        'S I G N U P',
                        style: TextStyle(color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.70,
                    child: TextFormField(
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.text_format,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.70,
                    child: TextFormField(
                      autofocus: false,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },

                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.70,
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'signupbutton',
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print('call');
                          setState(() {
                            email = emailController.text;
                            name = nameController.text;
                            password = passwordController.text;
                            registration(name!, email!, password!);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            'SignUp'.toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an Account?',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () =>
                            {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) =>
                                        LoginScreen(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                      (route) => false)
                            }, child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                  ),
                  Hero(
                      tag: 'footer',
                      child: Text(
                        'Made with ♥ by Greena',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  registration(String name, String email, String password) async {
    var result = await _service.signup(email, password);

    if (result is UserCredential) {
      // Success
      print('uid : ${result.user!.uid}    email : ${result.user!.email}');

      UserData user = UserData(
        name: name,
        email: email,
        id: result.user!.uid,
      );

      // Navigate to MainScreen and pass the userId
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(userId: result.user!.uid),
        ),
            (route) => false,
      );
    } else if (result is String) {
      // Error
      print(result);
    }
  }
}
