import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/view/home.dart';
import 'package:e_commers/view/note/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../const Widget/color.dart';

class addNote extends StatefulWidget {
  final String docid;
  @override
  addNote({super.key, required this.docid});

  @override
  State<addNote> createState() => _addNoteState();
}
class _addNoteState extends State<addNote> {
  var Notename =TextEditingController();
  var formkey=GlobalKey<FormState>();
  addnote(context) async {
    // Call the user's CollectionReference to add a new user
    CollectionReference categories = FirebaseFirestore.instance.collection('categories').doc(widget.docid).collection('note');
    await categories.add({'note':Notename.text})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    navigateTo(context, details(categoryid: widget.docid));
  }
  @override
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
                  controller: Notename ,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'addNote Title must be write';
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
                        addnote(context);
                        Fluttertoast.showToast(
                            msg: 'Task Added',
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
