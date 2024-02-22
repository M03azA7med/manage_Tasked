import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/const%20Widget/color.dart';
import 'package:e_commers/view/category/category.dart';
import 'package:e_commers/view/category/edit.dart';
import 'package:e_commers/view/login_screens.dart';
import 'package:e_commers/view/note/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'note/view.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override

  bool isloading=true;
  List<QueryDocumentSnapshot>data=[];
  getData()async{
    QuerySnapshot querySnapshot=
    await FirebaseFirestore.instance.collection("categories").where("id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    data.addAll(querySnapshot.docs);
    await Future.delayed(Duration(seconds: 1));
    isloading=false;
    setState(() {
    });
  }
  @override
  void initState() {
  getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: Icon(Icons.home),
      backgroundColor: prirmyColor,
      title: Text('HomePage'),
      actions: [
        Row(
          children: [
            Text('SIGN OUT'),
            IconButton(onPressed: () async {
              GoogleSignIn google =GoogleSignIn();
              google.disconnect();
              await FirebaseAuth.instance.signOut();
              navigateTo(context, loginScreen());
            },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),

      ],
    ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:1),
        itemCount: data.length,
        itemBuilder: (context, index) =>Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/folder.png',height: 100.0,),
              Text('${data[index]['name']}${data[index]['time']} '),

             Container(
               child: Row(

                 mainAxisAlignment: MainAxisAlignment.center,

                 children: [
                   IconButton(onPressed: ()async{
                     navigateTo(context,addNote(docid: data[index].id));
                   }, icon: Icon(Icons.add_task)),
                   IconButton(onPressed: ()async{
                     navigateTo(context,details(categoryid: data[index].id));
                   }, icon: Icon(Icons.view_agenda)),
                   IconButton(onPressed: ()async{
                     await FirebaseFirestore.instance.collection('categories').doc(data[index].id).delete();
                     navigateTo(context, home());
                   }, icon: Icon(Icons.mark_email_read_outlined)),
                   IconButton(onPressed: ()async{
                     navigateTo(context,editCategory(docid: data[index].id, oldname: data[index]['name']));
                   }, icon: Icon(Icons.edit)),
                   // IconButton(onPressed: ()async{
                   //   navigateTo(context,details(categoryid: data[index].id,));
                   // }, icon: Icon(Icons.add)),
                 ],
               ),
             ),
            ],
          ),
        ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateTo(context, category());
        },
        child: Icon(Icons.add) ,
      ),
    );
  }
}
