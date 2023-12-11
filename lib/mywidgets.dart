import 'package:flutter/material.dart';
import 'package:testsqlstudent/providers/DatabaseProvider.dart';
import 'models/student.dart';

class StudentItem extends StatelessWidget{

  final Student student;

  StudentItem({required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 120,
      child: Card(
        child: Row(
          children: [
            Text(student.id.toString()),
            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(student.major.toString()),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                  Icons.delete
                              ),
                              onPressed: () {
                                DatabaseProvider.instance.delete(student.id);
                              }
                          )
                          ,
                          Expanded(
                            child:  Container(
                              alignment: Alignment.centerRight,
                              child: Text(this.student.avg.toString()),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}

