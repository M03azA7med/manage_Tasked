
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commers/view/Register_screens.dart';
import 'package:e_commers/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../const Widget/color.dart';
class loginScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  bool isloading=false;
  // method to login via Google account
  Future signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    navigateTo(context, home());
    isloading=true;
    Future.delayed(Duration(seconds: 1));
  }
  Future signInWithFacebook(context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    navigateTo(context, home());
  }

  @override
  // method to sign in by google account
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      // ),
      body:isloading?Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(color: Colors.white10),
                      child: Image.asset('assets/images/profile.png')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                      },
                      child: Text(
                        'Don\'t Have Account',
                        style: TextStyle(
                          color: prirmyColor
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in to Continue',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email must be write';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'mo.......@gmail.com',
                    label: Text('Email Address'),
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is too short';
                    }
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: '****************',
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: Icon(Icons.visibility_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if(emailController.text==""){
                          Fluttertoast.showToast(
                              msg: 'please enter your email ',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.yellow,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }
                        await FirebaseAuth.instance.sendPasswordResetEmail(email:emailController.text).then((value) {
                          Fluttertoast.showToast(
                              msg: 'Check  your email ',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.yellow,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }).catchError((error){
                          print(error);
                          Fluttertoast.showToast(
                              msg: '$error',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      child: Text('Forgot Password?',
                      style: TextStyle(fontSize: 15.0, color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: prirmyColor),
                  child: MaterialButton(
                    onPressed: () async {
                      formkey.currentState!.validate();
                      try {
                        isloading=true;
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '-OR-',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                //Bottom Google login
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.grey.shade50,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      signInWithGoogle(context);
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),

                    child: Row(
                      children: [
                        Image.asset('assets/images/Google.png'),
                        SizedBox(
                          width: 100,
                        ),
                        Text('Sign In with Google'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Bottom Facbooke login
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.grey.shade50,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      signInWithFacebook(context);
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/Facebook.png'),
                        SizedBox(
                          width: 100,
                        ),
                        Text('Sign In with Facebook'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
