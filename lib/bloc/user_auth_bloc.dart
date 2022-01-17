import 'package:code_aamy_test/model/credential.dart';
import 'package:code_aamy_test/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserAuthBloc {
  final BehaviorSubject<Credentials> _subject = BehaviorSubject();

  BehaviorSubject<Credentials> get subject => _subject;

  final Repository _repository = Repository();

  doUserAuth() async {
    Credentials credentials = await _repository.signInWithGoogle();
    _subject.sink.add(credentials);
  }

  dispose(){
    _subject.close();
  }
}
