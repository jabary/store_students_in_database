
class Student{
  int id;
  String name;
  String major;
  double avg;

  Student({required this.id,required this.name,required this.major,required this.avg});

  factory Student.fromMap(Map<String, dynamic> record){
    return Student(
      id: record['id'],
      name: record['name'],
      major: record['major'],
      avg: record['avg']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'major': major,
      'avg': avg
    };
  }
}