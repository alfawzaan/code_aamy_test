import 'package:code_aamy_test/model/student.dart';

class StudentList{

  List<Student> studentList =[];
  String? error;
  StudentList.fromJson(List<dynamic> jsonObj):
      studentList = jsonObj.map((e) => Student.fromJson(e)).toList();

  StudentList.withError(this.error);
}