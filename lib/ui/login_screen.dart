import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/firebaseService/firebase_service.dart';
import 'package:shoes_app/ui/main_screen.dart';
import 'package:shoes_app/ui/registration_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseService _service = FirebaseService();
  bool _isLoading = false;
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
                  Hero(
                    tag: 'HerTitle',
                    child: Text(
                      'L O G I N',
                      style: TextStyle(color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
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
                    tag: 'loginbutton',
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          _login();
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
                            'Login'.toUpperCase(),
                            style: TextStyle(fontFamily: 'Poppins', color: Colors
                                .white),
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
                                        SignUpScreen(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                      (route) => false)
                            }, child: Text(
                            'SignUp',
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
                ]
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    // Show progress indicator
    setState(() => _isLoading = true);

    String email = emailController.text;
    String password = passwordController.text;

    // Call the sign-in method from FirebaseService
    _service.signInWithEmailPassword(
      email: email,
      password: password,
      onSuccess: (UserCredential credential) {
        // Hide progress indicator
        setState(() => _isLoading = false);

        // Get the user ID from the UserCredential object
        String userId = credential.user!.uid;

        // Navigate to MainScreen and pass the userId
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(userId: userId),
          ),
              (route) => false,
        );
      },
      onError: (String message) {
        // Hide progress indicator
        setState(() => _isLoading = false);

        // Show error message
        print(message);
      },
    );
  }

}
