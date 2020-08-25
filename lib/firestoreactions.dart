import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Questions {
  final String documentId;
  Questions({@required this.documentId});

  trueFalse(String question, String questionType, String image, String video, int score, List answers, bool correctAnswer)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "score": score,
      "answers": answers,
      "correct_answer": correctAnswer
    });
  }

  mcq(String question, String questionType, String image, String video, int score, List answers, String correctAnswer)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "score": score,
      "answers": answers,
      "correct_answer": correctAnswer
    });
  }

  reArrange(String question, String questionType, String image, String video, int score, List answers, List<String> correctAnswer)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "score": score,
      "answers": answers,
      "correct_answer": correctAnswer
    });
  }

  poll(String question, String questionType, String image, String video, List answers)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "answers": answers,
    });

    await Firestore.instance.collection('Quizes').document(documentId).collection('Polls').document('Poll_value_$count').setData({
      "option_1": 0,
      "option_2": 0,
      "option_3": 0,
      "option_4": 0,
    });
  }

  longPoll(String question, String questionType, String image, String video, List answers)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "answers": answers,
    });

    await Firestore.instance.collection('Quizes').document(documentId).collection('LongPolls').document('Poll_value_$count').setData({
      "option_1": 0,
      "option_2": 0,
      "option_3": 0,
      "option_4": 0,
      "option_5": 0,
      "option_6": 0,
      "option_7": 0,
      "option_8": 0,
      "option_9": 0,
      "option_10": 0,
      "option_11": 0,
      "option_12": 0,
      "option_13": 0,
      "option_14": 0,
      "option_15": 0,
      "option_16": 0,
      "option_17": 0,
      "option_18": 0,
      "option_19": 0,
      "option_20": 0,
    });
  }

  delQuestion(String questionId)async{
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document(questionId).get().then((value) {
      if (value.data['question_type'] == 'Poll'){
        delQuestionPoll(questionId);
      } else if (value.data['question_type'] == 'LongPoll'){
        delQuestionLongPoll(questionId);
      }
    });
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').document(questionId).delete();
  }
  
  delQuestionPoll(String questionId)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = (value.documents.indexWhere((element) => element.documentID == questionId))+1);

    await Firestore.instance.collection('Quizes').document(documentId).collection('Polls').document('Poll_value_$count').delete();
  }
  
  delQuestionLongPoll(String questionId)async{
    int count;
    await Firestore.instance.collection('Quizes').document(documentId).collection('Questions').getDocuments().then((value) => count = (value.documents.indexWhere((element) => element.documentID == questionId))+1);
    await Firestore.instance.collection('Quizes').document(documentId).collection('LongPolls').document('Poll_value_$count').delete();
  }
}

class Quizes{
  
  CollectionReference collection = Firestore.instance.collection('Quizes');
  
  addQuiz(String quizName, int startTime, int endTime)async{
    await collection.document(quizName).setData({
      "start_time": startTime,
      "end_time": endTime
    });
  }


  delQuiz(String quizName)async{
    await collection.document(quizName).delete();
  }
}


class Polls{

  CollectionReference collection = Firestore.instance.collection('Polls');

  addPoll(String pollName, int startTime, int endTime)async{
    await collection.document(pollName).setData({
      "start_time": startTime,
      "end_time": endTime
    });
  }

  delPoll(String pollName)async{
    await collection.document(pollName).delete();
  }
}

class PollQuestions{

  final String documentId;
  PollQuestions({@required this.documentId});

  poll(String question, String questionType, String image, String video, List answers)async{
    int count;
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "answers": answers,
    });

    await Firestore.instance.collection('Polls').document(documentId).collection('Polls').document('Poll_value_$count').setData({
      "option_1": 0,
      "option_2": 0,
      "option_3": 0,
      "option_4": 0,
    });
  }

  longPoll(String question, String questionType, String image, String video, List answers)async{
    int count;
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').getDocuments().then((value) => count = value.documents.length + 1);
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').document('Question_$count').setData({
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "answers": answers,
    });

    await Firestore.instance.collection('Polls').document(documentId).collection('LongPolls').document('Poll_value_$count').setData({
      "option_1": 0,
      "option_2": 0,
      "option_3": 0,
      "option_4": 0,
      "option_5": 0,
      "option_6": 0,
      "option_7": 0,
      "option_8": 0,
      "option_9": 0,
      "option_10": 0,
      "option_11": 0,
      "option_12": 0,
      "option_13": 0,
      "option_14": 0,
      "option_15": 0,
      "option_16": 0,
      "option_17": 0,
      "option_18": 0,
      "option_19": 0,
      "option_20": 0,
    });
  }

  delQuestion(String questionId)async{
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').document(questionId).get().then((value) {
      if (value.data['question_type'] == 'Poll'){
        delQuestionPoll(questionId);
      } else if (value.data['question_type'] == 'LongPoll'){
        delQuestionLongPoll(questionId);
      }
    });
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').document(questionId).delete();
  }

  delQuestionPoll(String questionId)async{
    int count;
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').getDocuments().then((value) => count = (value.documents.indexWhere((element) => element.documentID == questionId))+1);
    await Firestore.instance.collection('Polls').document(documentId).collection('Polls').document('Poll_value_$count').delete();
  }

  delQuestionLongPoll(String questionId)async{
    int count;
    await Firestore.instance.collection('Polls').document(documentId).collection('Questions').getDocuments().then((value) => count = (value.documents.indexWhere((element) => element.documentID == questionId))+1);
    await Firestore.instance.collection('Polls').document(documentId).collection('LongPolls').document('Poll_value_$count').delete();
  }
}