import 'package:e_commers/view/home.dart';
import 'package:e_commers/view/login_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const Widget/color.dart';

class Register extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: SingleChildScrollView(
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
                Text('Sign Up',
                  style: TextStyle(
                  fontSize:20.0,
                  color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 70.0,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name  must be write';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // hintText: 'mo.......@gmail.com',
                    label: Text('Name'),
                    prefixIcon: Icon(CupertinoIcons.textformat_abc),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30.0,),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email must be write';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // hintText: 'mo.......@gmail.com',
                    label: Text('Email Address'),
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30.0,),
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
                    // hintText: '****************',
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: Icon(Icons.visibility_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30.0,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: prirmyColor),
                  child: MaterialButton(
                    onPressed: () async {
                      formkey.currentState!.validate();
                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen(),));

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          Fluttertoast.showToast(
                              msg: 'The password provided is too weak. ',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          Fluttertoast.showToast(
                              msg: 'The account already exists for that email. ',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have Acoount?'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen(),));
                    },
                        child: 
                        Text('Login',style: TextStyle(
                      color: prirmyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
