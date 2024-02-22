import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../const Widget/color.dart';

class category extends StatelessWidget {
  // const category({super.key});
  @override

  var categoriesname =TextEditingController();
  var TimeController =TextEditingController();
  var formkey=GlobalKey<FormState>();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
   addcategoriesn(context) async {
    // Call the user's CollectionReference to add a new user
     await categories.add({"name":categoriesname.text ,"time":TimeController.text,"id" :FirebaseAuth.instance.currentUser!.uid})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    navigateTo(context, home());
  }
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Note'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: categoriesname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'category Title must be write';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // hintText: 'mo.......@gmail.com',
                    label: Text('Title'),
                    prefixIcon: Icon(CupertinoIcons.textformat_abc),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  controller: TimeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'category Title must be write';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // hintText: 'mo.......@gmail.com',
                    label: Text('Time Of Task'),
                    prefixIcon: Icon(CupertinoIcons.time),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  width: 250.0,
                  decoration: BoxDecoration(color: prirmyColor,
                  borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      if(formkey.currentState!.validate()){
                        addcategoriesn(context);
                        Fluttertoast.showToast(
                            msg: 'Categories Title Added',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
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
