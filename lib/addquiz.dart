import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizadmin/firestoreactions.dart';

class AddQuiz extends StatefulWidget {
  final bool quiz;
  AddQuiz({@required this.quiz});
  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final _quizName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text((widget.quiz)?'Add Quiz':'Add Poll'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextField(
                      controller: _quizName,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: (widget.quiz)?'Quiz name':'Poll name',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "${startDate.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () => _startDate(context),
                child: Text(
                  'Select Start Date',
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                color: Colors.greenAccent,
              ),
              Text(
                "${endDate.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () => _endDate(context),
                child: Text(
                  'Select End Date',
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            if (_quizName.text.isNotEmpty){
              uploading();
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  uploading(){
    if (widget.quiz){
      Quizes _quizes = Quizes();
      _quizes.addQuiz(_quizName.text, startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);
    } else {
      Polls _polls = Polls();
      _polls.addPoll(_quizName.text, startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);
    }
  }
}
