import 'package:cloud_firestore/cloud_firestore.dart';

class Questions {
  DocumentReference document = Firestore.instance.collection('quetions').document('rFZFFNX1S2BxPMuOI1vM');

  trueFalse(String question, String questionType, String image, String video, int score, List answers, bool correctAnswer)async{
    int count;
    await document.get().then((value) {
      count = value.data['event_info']['question_count'];
      count++;
    });
    await document.updateData({"questions": FieldValue.arrayUnion([{
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "score": score,
      "answers": answers,
      "correct_answer": correctAnswer
    }])});
    await document.updateData({"event_info": {"question_count": count}});
  }

  mcq(String question, String questionType, String image, String video, int score, List answers, String correctAnswer)async{
    int count;
    await document.get().then((value) {
      count = value.data['event_info']['question_count'];
      count++;
    });
    await document.updateData({"questions": FieldValue.arrayUnion([{
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "score": score,
      "answers": answers,
      "correct_answer": correctAnswer
    }])});
    await document.updateData({"event_info": {"question_count": count}});
  }

  reArrange(String question, String questionType, String image, String video, int score, List answers, List<String> correctAnswer)async{
    int count;
    await document.get().then((value) {
      count = value.data['event_info']['question_count'];
      count++;
    });
    await document.updateData({"questions": FieldValue.arrayUnion([{
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "score": score,
      "answers": answers,
      "correct_answer": correctAnswer
    }])});
    await document.updateData({"event_info": {"question_count": count}});
  }

  poll(String question, String questionType, String image, String video, List answers)async{
    int count;
    await document.get().then((value) {
      count = value.data['event_info']['question_count'];
      count++;
    });
    await document.updateData({"questions": FieldValue.arrayUnion([{
      "question": question,
      "question_type": questionType,
      "image": image,
      "video": video,
      "answers": answers,
    }])});
    await document.updateData({"event_info": {"question_count": count}});
  }

  delQuestion(String question, int index)async{
    int count;
    dynamic removeQuestion;
    await document.get().then((value) {
      removeQuestion = value.data['questions'][index];
      count = value.data['event_info']['question_count'];
      count--;
    });
    await document.updateData({"questions": FieldValue.arrayRemove([removeQuestion])});
    await document.updateData({"event_info": {"question_count": count}});
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