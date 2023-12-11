
import 'package:flutter/material.dart';
import 'package:testsqlstudent/models/student.dart';
import 'package:testsqlstudent/providers/DatabaseProvider.dart';

class StudentForm extends StatelessWidget{

  final nameController = TextEditingController();
  final majorController = TextEditingController();
  final avgController = TextEditingController();

  addStudent(){
    Student student = Student(id: -1, name: nameController.text, major: majorController.text, avg: double.parse(avgController.text));
    DatabaseProvider.instance.add(student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new student"),),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Student Name"
            ),
            controller: nameController,

          ),
          TextField(
            decoration: const InputDecoration(
                hintText: "Student Major"
            ),
            controller: majorController,),
          TextField(
            decoration: const InputDecoration(
                hintText: "Student Average"
            ),
            controller: avgController,),
          ElevatedButton(
              onPressed: (){
                addStudent();
              },
              child: Text("Add")
          )
        ],
      )
    );
  }

}