import 'package:hive/hive.dart';
import 'package:using_hive_prgrm/Login_Using_Hive/model/usermodel.dart';

class DBFunction{
  DBFunction.internal();
  //if the class have one object we can called instance
  //singleton class
static DBFunction instance=DBFunction.internal();

factory DBFunction(){ //factory constructor
  return instance;
}

  Future<void>userSignUp(User user)async {
  final db=await Hive.openBox<User>("user");
  db.put(user.id, user);
  }

  Future<List<User>>getUser()async {
  final db=await Hive.openBox<User>('users');
  return db.values.toList();
  }


}