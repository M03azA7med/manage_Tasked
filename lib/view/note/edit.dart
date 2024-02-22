import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/view/home.dart';
import 'package:e_commers/view/note/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../const Widget/color.dart';

class editNote extends StatefulWidget {
  final String docid;
  final String categorydocid;
  final String value;

  const editNote({super.key, required this.docid, required this.categorydocid, required this.value});
  @override
  State<editNote > createState() => _editNoteState();
}
class _editNoteState extends State<editNote > {
  var Notename =TextEditingController();
  var formkey=GlobalKey<FormState>();
  editNote (context) async {
    // Call the user's CollectionReference to add a new user
    CollectionReference categories = FirebaseFirestore.instance.collection('categories').doc(widget.categorydocid).collection('note');
    await categories.doc(widget.docid).update({'note':Notename.text})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    navigateTo(context, details(categoryid:widget.categorydocid));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Notename.text=widget.value;
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
                      return 'editNote  Title must be write';
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
                        editNote(context);
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
                      'Edit',
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
