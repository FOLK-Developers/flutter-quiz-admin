import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizadmin/firestoreactions.dart';

class DeleteQuiz extends StatefulWidget {
  final bool quiz;
  DeleteQuiz({@required this.quiz});
  @override
  _DeleteQuizState createState() => _DeleteQuizState();
}

class _DeleteQuizState extends State<DeleteQuiz> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Delete Quiz'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection((widget.quiz)?'Quizes':'Polls').snapshots(),
            builder: (context, snapshot){
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              } else {
                return ListView(
                  children: List.generate(snapshot.data.documents.length, (index) {
                    return Card(
                      elevation: 5.0,
                      child: ListTile(
                        title: Text(snapshot.data.documents[index].documentID ?? "null"),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text('Are you sure you want to delete this !'),
                                  actions: [
                                    FlatButton(
                                      child: Text('continue'),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        if(widget.quiz){
                                          Quizes _quizes = Quizes();
                                          _quizes.delQuiz(snapshot.data.documents[index].documentID);
                                        } else {
                                          Polls _polls = Polls();
                                          _polls.delPoll(snapshot.data.documents[index].documentID);
                                        }
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('cancel'),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                      ),
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
