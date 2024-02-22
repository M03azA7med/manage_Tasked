import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../const Widget/color.dart';

class editCategory extends StatefulWidget {

final String docid;
final String oldname;

const editCategory({super.key, required this.docid, required this.oldname});

@override
State<editCategory> createState() => _editCategoryState();
}

class _editCategoryState extends State<editCategory> {
  // const editCategory({super.key});
  var categoriesname =TextEditingController();
  var formkey=GlobalKey<FormState>();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  editcategoriesn(context) async {
    // Call the user's CollectionReference to add a new user
    await categories.doc(widget.docid).set({"name": categoriesname.text},SetOptions(merge: true))
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    navigateTo(context, home());
  }
@override
  void initState() {
    super.initState();
    categoriesname.text=widget.oldname;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
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
                      return 'editCategory Title must be write';
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
                Container(
                  width: 250.0,
                  decoration: BoxDecoration(color: prirmyColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      if(formkey.currentState!.validate()){
                        editcategoriesn(context);
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
