import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizadmin/firestoreactions.dart';

class AddPoll extends StatefulWidget {
  final String documentId;
  AddPoll({@required this.documentId});
  @override
  _AddPollState createState() => _AddPollState();
}

class _AddPollState extends State<AddPoll> {
  final _question = TextEditingController();
  final _imageLink = TextEditingController();
  final _videoId = TextEditingController();
  final _option1 = TextEditingController();
  final _option2 = TextEditingController();
  final _option3 = TextEditingController();
  final _option4 = TextEditingController();

  String questionType = 'Question Type';
  Widget typeOfQuestion(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: DropdownButton<String>(
            value: questionType,
            isExpanded: true,
            icon: Icon(Icons.arrow_downward),
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                questionType = newValue;
              });
            },
            items: <String>['Question Type', 'Poll', 'LongPoll']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void initState(){
    _optionsControllers = [];
    super.initState();
  }

  List<TextEditingController> _optionsControllers;
  Widget options(){
    if (questionType == 'LongPoll'){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: ExpansionTile(
              title: Text('Options'),
              children: List.generate(20, (index) {
                _optionsControllers.add(TextEditingController());
                return Card(
                  child: TextField(
                    controller: _optionsControllers.elementAt(index),
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Option',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
    } else {
      _optionsControllers = [];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: ExpansionTile(
              title: Text('Options'),
              children: <Widget>[
                TextField(
                  controller: _option1,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Option',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                  ),
                ),
                TextField(
                  controller: _option2,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Option',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                  ),
                ),
                TextField(
                  controller: _option3,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Option',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                  ),
                ),
                TextField(
                  controller: _option4,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Option',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  String image = 'Is there an image to display';
  String video = 'Is there a video to play';
  Widget mediaOptions(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ExpansionTile(
            title: Text('Media Options'),
            children: <Widget>[
              DropdownButton<String>(
                value: image,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    image = newValue;
                  });
                },
                items: <String>['Is there an image to display', 'Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              (image == 'Yes') ? TextField(
                controller: _imageLink,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Image Link',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                ),
              ) : Container(),
              DropdownButton<String>(
                value: video,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    video = newValue;
                  });
                },
                items: <String>['Is there a video to play', 'Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              (video == 'Yes') ? TextField(
                controller: _videoId,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Video Id',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Poll'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 150.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              typeOfQuestion(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextField(
                      controller: _question,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Question',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                      ),
                    ),
                  ),
                ),
              ),
              options(),
              mediaOptions()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            PollQuestions _pollQuestions = PollQuestions(documentId: widget.documentId);
            if(questionType == 'Poll'){
              _pollQuestions.poll(_question.text, questionType, (image == 'Yes')?_imageLink.text:null, (video == 'Yes')?_videoId.text:null, [_option1.text, _option2.text, _option3.text, _option4.text]);
            } else if (questionType == 'LongPoll'){
              List<String> _answers = [];
              _optionsControllers.forEach((element) {_answers.add(element.text);});
              _pollQuestions.longPoll(_question.text, questionType, (image == 'Yes')?_imageLink.text:null, (video == 'Yes')?_videoId.text:null, _answers);
              _answers = [];
            }
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => AddPoll(documentId: widget.documentId,),
                transitionDuration: Duration.zero,
              ),
            );
          },
          tooltip: 'Add Poll',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
