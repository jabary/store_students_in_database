import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:testsqlstudent/models/student.dart';
import 'package:testsqlstudent/mywidgets.dart';
import 'package:testsqlstudent/providers/DatabaseProvider.dart';
import 'package:testsqlstudent/studentForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> DatabaseProvider.instance,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:  ListDisplay()
      ),
    );


  }
}

class ListDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentForm()));
              },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, myprovider, child){
          return  FutureBuilder(
              future:  DatabaseProvider.instance.getAllStudents(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  List<Student> students = snapshot.data!;
                  for (var student in students){
                    print(student.name);
                    print(student.major);
                  }
                  return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index){
                        return StudentItem(student: students[index]);
                      });
                }
                else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else{
                  return const CircularProgressIndicator();
                }
              }
          );
        },
      )



    );
  }

}



