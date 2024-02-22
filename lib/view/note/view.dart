import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/view/category/category.dart';
import 'package:e_commers/view/note/add.dart';
import 'package:e_commers/view/note/edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../const Widget/color.dart';
import '../home.dart';
import '../category/edit.dart';

class details extends StatefulWidget {
  final String categoryid;
  const details({super.key, required this.categoryid});
  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  //to storng the data come from firebase
  List<QueryDocumentSnapshot>data=[];
  getData()async{
    QuerySnapshot querySnapshot=
    await FirebaseFirestore.instance.collection("categories").doc(widget.categoryid).collection("note").get();
    data.addAll(querySnapshot.docs);
    await Future.delayed(Duration(seconds: 1));
    // isloading=false;
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: data.length,
        itemBuilder: (context, index) =>Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,50,0,0),
            child: Column(
              children: [
                // Image.asset('assets/images/folder.png',height: 110.0,),
                Text('${data[index]['note']}',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,40,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: ()async{
                        await FirebaseFirestore.instance.collection('categories').doc(widget.categoryid).collection('note').doc(data[index].id).delete();
                        navigateTo(context, details(categoryid: widget.categoryid));
                      }, icon: Icon(Icons.delete_forever)),
                      IconButton(onPressed: ()async{
                        navigateTo(context,editNote(docid: data[index].id , categorydocid:widget.categoryid, value:data[index]['note'] ));
                      }, icon: Icon(Icons.edit)),
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
          navigateTo(context, addNote(docid: widget.categoryid));
        },
        child: Icon(Icons.add) ,
      ),

    );
  }
}
