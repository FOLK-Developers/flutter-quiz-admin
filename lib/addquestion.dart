import 'package:flutter/material.dart';
//import 'package:quizadmin/firestoreactions.dart';

class AddQuestion extends StatefulWidget {
  final String documentId;
  AddQuestion({@required this.documentId});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _question = TextEditingController();
  final _imageLink = TextEditingController();
  final _videoId = TextEditingController();
  final _score = TextEditingController();


  final _option1 = TextEditingController();
  final _option2 = TextEditingController();
  final _option3 = TextEditingController();
  final _option4 = TextEditingController();
  Widget options(){
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
              (questionType == 'True/False') ? Container() : TextField(
                controller: _option3,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Option',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                ),
              ),
              (questionType == 'True/False') ? Container() : TextField(
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
                if (questionType == 'True/False'){
                  _option1.text = 'True';
                  _option2.text = 'False';
                } else {
                  _option1.text = '';
                  _option2.text = '';
                }
              });
            },
            items: <String>['Question Type', 'True/False', 'MCQ', 'Re-arrange', 'Poll']
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

  // ignore: non_constant_identifier_names
  String correct_answer = 'Correct Answer';
  Widget correctAnswer(){
    if (questionType == 'MCQ'){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: DropdownButton<String>(
              value: correct_answer,
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
                  correct_answer = newValue;
                });
              },
              items: <String>['Correct Answer', 'option 1', 'option 2', 'option 3', 'option 4']
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
    } else if (questionType == 'True/False'){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: DropdownButton<String>(
              value: correct_answer,
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
                  correct_answer = newValue;
                });
              },
              items: <String>['Correct Answer', 'True', 'False']
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
    } else {
      return Container();
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            typeOfQuestion(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
            correctAnswer(),
            mediaOptions(),
            (questionType == 'Poll')?Container():Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    controller: _score,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Score',
//                hintStyle: TextStyle(fontSize: _height*0.025),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (validate()){
            uploading();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => AddQuestion(),
                transitionDuration: Duration.zero,
              ),
            );
          }
        },
        tooltip: 'Add answers and reset',
        child: Icon(Icons.add),
      ),
    );
  }

  bool validate(){
    imageValidiation();
    videoValidiation();
    mediaValidiation();
    scoreValidiation();
    optionValidation();
    if (_validMedia && _validScore && _validOptions){
      return true;
    } else {
      return false;
    }
  }

  dynamic rightAnswer;
  void right(){
    switch(correct_answer){
      case 'option 1':{
        rightAnswer = _option1.text;
      } break;
      case 'option 2':{
        rightAnswer = _option2.text;
      } break;
      case 'option 3':{
        rightAnswer = _option3.text;
      } break;
      case 'option 4':{
        rightAnswer = _option4.text;
      } break;
      case 'True':{
        rightAnswer = true;
      } break;
      case 'False':{
        rightAnswer = false;
      } break;
      default:{
        rightAnswer = null;
      } break;
    }
  }

  bool _validImage = false;
  imageValidiation(){
    if(image == 'Yes'){
      if (_imageLink.text.isEmpty){
        _validImage = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Video Id can\'t be empty', textAlign: TextAlign.center,)));
      } else {
        _validImage = true;
      }
    } else {
      _validImage = true;
    }
  }

  bool _validVideo = false;
  videoValidiation(){
    if(video == 'Yes'){
      if (_videoId.text.isEmpty){
        _validVideo = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Image Link can\'t be empty', textAlign: TextAlign.center,)));
      } else {
        _validVideo = true;
      }
    } else {
      _validVideo = true;
    }
  }

  bool _validMedia = false;
  mediaValidiation(){
    if ((_validImage) && (_validVideo)) {
      _validMedia = true;
    }
  }

  bool _validScore = false;
  scoreValidiation(){
    if (questionType == 'Poll'){
      _validScore = true;
    } else {
      if (_score.text.isEmpty){
        _validScore = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Score can\'t be empty', textAlign: TextAlign.center,)));
      } else {
        _validScore = true;
      }
    }
  }

  bool _validOptions = false;
  optionValidation(){
    if (_question.text.isNotEmpty){
      if (questionType == 'True/False'){
        right();
        if ((_option1.text.isEmpty) || (_option2.text.isEmpty) || (rightAnswer == null)) {
          _validOptions = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(rightAnswer == null?'Please choose a correct answer':'options can\'t be empty', textAlign: TextAlign.center,)));
        } else {
          setState(() {
            _validOptions = true;
          });
        }
      } else if (questionType == 'MCQ'){
        right();
        if ((_option1.text.isEmpty) || (_option2.text.isEmpty) || (_option3.text.isEmpty) || (_option4.text.isEmpty) || (rightAnswer == null)){
          _validOptions = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(rightAnswer == null?'Please choose a correct answer':'options can\'t be empty', textAlign: TextAlign.center,)));
        } else {
          setState(() {
            _validOptions = true;
          });
        }
      } else if ((questionType == 'Re-arrange') || (questionType == 'Poll')){
        if ((_option1.text.isEmpty) || (_option2.text.isEmpty) || (_option3.text.isEmpty) || (_option4.text.isEmpty)){
          _validOptions = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('options can\'t be empty', textAlign: TextAlign.center,)));
        } else {
          setState(() {
            _validOptions = true;
          });
        }
      }
    } else {
      _validOptions = false;
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please enter a question', textAlign: TextAlign.center,)));
    }
  }

  uploading(){
    int score = int.parse(_score.text);
    Questions upload = Questions();
    switch(questionType){
      case 'True/False':{
        upload.trueFalse(_question.text, questionType, (image == 'Yes')?_imageLink.text:null, (video == 'Yes')?_videoId.text:null, score, [_option1.text, _option2.text], rightAnswer);
      }break;
      case 'MCQ':{
        upload.mcq(_question.text, questionType, (image == 'Yes')?_imageLink.text:null, (video == 'Yes')?_videoId.text:null, score, [_option1.text, _option2.text, _option3.text, _option4.text], rightAnswer);
      }break;
      case 'Re-arrange':{
        upload.reArrange(_question.text, questionType, (image == 'Yes')?_imageLink.text:null, (video == 'Yes')?_videoId.text:null, score, [_option3.text, _option1.text, _option4.text, _option2.text], [_option1.text, _option2.text, _option3.text, _option4.text]);
      }break;
      case 'Poll':{
        upload.poll(_question.text, questionType, (image == 'Yes')?_imageLink.text:null, (video == 'Yes')?_videoId.text:null, [_option1.text, _option2.text, _option3.text, _option4.text]);
      }break;
      default:{
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please choose a question type', textAlign: TextAlign.center,)));
      }break;
    }
  }
}
