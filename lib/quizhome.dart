import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizadmin/addquestion.dart';
import 'package:quizadmin/deletequestion.dart';

class QuizHome extends StatefulWidget {
  final String documentId;
  QuizHome({@required this.documentId});
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Home'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('Quizes').document(widget.documentId).collection('Questions').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
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
                  tooltip: 'Add Question',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestion(documentId: widget.documentId),));
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: 'Delete',
                  tooltip: 'Delete Question',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteQuestion(documentId: widget.documentId,),));
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
