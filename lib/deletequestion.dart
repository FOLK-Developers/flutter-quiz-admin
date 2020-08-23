import 'package:flutter/material.dart';
//import 'package:quizadmin/firestoreactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteQuestion extends StatefulWidget {
  final String documentId;
  DeleteQuestion({@required this.documentId});
  @override
  _DeleteQuestionState createState() => _DeleteQuestionState();
}

class _DeleteQuestionState extends State<DeleteQuestion> {
  Questions _question = Questions();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Delete Question'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('Quizes').document(widget.documentId).collection('Questions').snapshots(),
            builder: (context, snapshot){
              if (!snapshot.hasData) {
                return Text('Loading');
              } else {
                return ListView(
                  children: List.generate(snapshot.data.documents.length, (index) {
                    return Card(
                      elevation: 5.0,
                      child: ListTile(
                        title: Text(snapshot.data.documents[index].data['question']),
                        subtitle: Text(snapshot.data.documents[index].data['question_type']),
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
//                                      _question.delQuestion(snapshot.data['questions'][index]['question'], index);
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
