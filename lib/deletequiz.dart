import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizadmin/firestoreactions.dart';

class DeleteQuiz extends StatefulWidget {
  @override
  _DeleteQuizState createState() => _DeleteQuizState();
}

class _DeleteQuizState extends State<DeleteQuiz> {
  Quizes _quizes = Quizes();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Delete Quiz'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('Quizes').where("start_time", isEqualTo: 1).snapshots(),
            builder: (context, snapshot){
              if (!snapshot.hasData) {
                return Text('Loading');
              } else {
                return ListView(
                  children: List.generate(snapshot.data.documents.length, (index) {
                    return Card(
                      elevation: 5.0,
                      child: ListTile(
                        title: Text(snapshot.data.documents[index].documentID ?? "null"),
//                        subtitle: Text(snapshot.data['questions'][index]['question_type']),
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
                                        _quizes.delQuiz(snapshot.data.documents[index].documentID);
//                                        _question.delQuestion(snapshot.data['questions'][index]['question'], index);
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
