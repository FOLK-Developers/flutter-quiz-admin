import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizadmin/addquiz.dart';
import 'package:quizadmin/pollhome.dart';
import 'package:quizadmin/quizhome.dart';
import 'deletequiz.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Admin'),
        ),
        body: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width),
            child: (_selectedIndex==0)?_quizTable():_pollTable(),
          ),
        ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                title: Text('Quiz'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.poll),
                title: Text('Poll'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'Add',
                  tooltip: (_selectedIndex==0)?'Add Quiz':'Add Poll',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuiz(quiz: quiz,),));
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: 'Delete',
                  tooltip: (_selectedIndex==0)?'Delete Quiz':'Delete Poll',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteQuiz(quiz: quiz,),));
                  },
                  child: Icon(Icons.delete),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _quizTable(){
    return StreamBuilder(
      stream: Firestore.instance.collection('Quizes').snapshots(),
      builder: (context, snapshot) {
        return DataTable(
          columnSpacing: 0.0,
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Start Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'End Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: _buildQuizes(snapshot),
        );
      }
    );
  }

  List<DataRow> _buildQuizes(AsyncSnapshot snapshot){
    List<DataRow> newList = List.generate(snapshot.data.documents.length, (index) {
      return new DataRow(
          onSelectChanged: (selected){
            if(selected){
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizHome(documentId: snapshot.data.documents[index].documentID)));
            } else {
              print('not selected');
            }
          },
          cells: [
            DataCell(Text(snapshot.data.documents[index].documentID)),
            DataCell(Text(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index].data['start_time']).toLocal().toString().split(' ')[0])),
            DataCell(Text(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index].data['end_time']).toLocal().toString().split(' ')[0])),
          ]);
    });
    return newList;
  }

  Widget _pollTable(){
    return StreamBuilder(
      stream: Firestore.instance.collection('Polls').snapshots(),
      builder: (context, snapshot) {
        return DataTable(
          columnSpacing: 0.0,
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Start Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'End Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: _buildPolls(snapshot),
        );
      }
    );
  }

  List<DataRow> _buildPolls(AsyncSnapshot snapshot){
    List<DataRow> newList = List.generate(snapshot.data.documents.length, (index) {
      return new DataRow(
          onSelectChanged: (selected){
            if(selected){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PollHome(documentId: snapshot.data.documents[index].documentID)));
            } else {
              print('not selected');
            }
          },
          cells: [
            DataCell(Text(snapshot.data.documents[index].documentID)),
            DataCell(Text(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index].data['start_time']).toLocal().toString().split(' ')[0])),
            DataCell(Text(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index].data['end_time']).toLocal().toString().split(' ')[0])),
          ]);
    });
    return newList;
  }

  int _selectedIndex = 0;
  bool quiz = true;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        quiz = true;
      } else {
        quiz = false;
      }
    });
  }
}
