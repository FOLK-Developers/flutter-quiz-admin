import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizadmin/addpoll.dart';
import 'package:quizadmin/deletepoll.dart';

class PollHome extends StatefulWidget {
  final String documentId;
  PollHome({@required this.documentId});
  @override
  _PollHomeState createState() => _PollHomeState();
}

class _PollHomeState extends State<PollHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Poll Home'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('Polls').document(widget.documentId).collection('Questions').snapshots(),
            builder: (context, snapshot){
              if (!snapshot.hasData){
                return LinearProgressIndicator();
              } else {
                return ListView(
                  children: List.generate(snapshot.data.documents.length, (index) {
                    return Card(
                      elevation: 5.0,
                      child: ListTile(
                        title: Text(snapshot.data.documents[index].data['question']),
                        subtitle: Text(snapshot.data.documents[index].data['question_type']),
                      ),
                    );
                  }),
                );
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'Add',
                tooltip: 'Add Quiz',
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPoll(documentId: widget.documentId),));
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                heroTag: 'Delete',
                tooltip: 'Delete Quiz',
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeletePoll(documentId: widget.documentId),));
                },
                child: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
