import 'package:code_aamy_test/model/studentlist.dart';
import 'package:code_aamy_test/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class StudentListBloc{

  final BehaviorSubject<StudentList> _subject = BehaviorSubject();
  BehaviorSubject<StudentList> get subject => _subject;
  final Repository _repository = Repository();

  getStudentList()async{
    StudentList studentList =await _repository.getStudentList();
    subject.sink.add(studentList);
  }

  dispose(){
    _subject.close();
  }
}