import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:using_hive_prgrm/Login_Using_Hive/database/database.dart';
import 'package:using_hive_prgrm/Login_Using_Hive/model/usermodel.dart';
import 'package:using_hive_prgrm/Login_Using_Hive/screens/Hompage.dart';
import 'package:using_hive_prgrm/Login_Using_Hive/screens/Registeration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');
  runApp(GetMaterialApp(
    home: Loginhive(),
  ));
}

class Loginhive extends StatefulWidget {
  @override
  State<Loginhive> createState() => _LoginhiveState();
}

class _LoginhiveState extends State<Loginhive> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Image(
                  image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/2552/2552801.png"),
                  height: 200,
                  width: 200,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: uname,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Please enter your number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final userlist = await DBFunction.instance.getUser();
                    findUser(userlist);
                  },
                  child: Text("Log in"),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(290, 30),
                      backgroundColor: Colors.green[900]),
                ),
              ),
              TextButton(onPressed: (){
                Get.to(Registeratonn());
              }, child: Text("Please Register"))
            ],
          ),
        ),
      ),
    );
  }
  Future<void> findUser(List<User> userlist) async{
    final email    = uname.text.trim();
    final password = pass.text.trim();
    bool userFound = false;
    final validate = await validateLogin(email,password);

    if(validate == true){
      await Future.forEach(userlist, (user) {
        if(user.email == email  && user.password == password){
          userFound = true;
        }else{
          userFound = false;
        }
      });
      if(userFound == true){
        Get.offAll(()=> Hompage(email :email));
        Get.snackbar("Success", "Login Success",
            backgroundColor: Colors.green);
      }else{
        Get.snackbar("Error", "Incorrect email/Password",
            backgroundColor: Colors.red);
      }
    }
  }
  Future<bool> validateLogin(String email, String password) async {
    if(email != '' && password != ''){
      return true;
    }else{
      Get.snackbar("Error", "Fields cannot be empty",backgroundColor: Colors.red);
      return false;
    }

  }
}


//   Future<void> findUser(List<User> userlist) async {
//     final email = uname.text.trim();
//     final password = pass.text.trim();
//     bool userFound = false;
//     final validate = await validateLogin(email, password);
//
//     if (validate == true) {
//       await Future.forEach(userlist, (user) {
//         if (user.email == email && user.password == password) {
//           userFound = true;
//         } else {
//           userFound = false;
//         }
//       });
//       if (userFound == true) {
//         Get.offAll(() => Hompage(email: email));
//         Get.snackbar("Success", "Login Seccess", backgroundColor: Colors.green);
//       } else {
//         Get.snackbar("Error", "Incorrect email/password",
//             backgroundColor: Colors.red);
//       }
//     }
//   }
//   validateLogin(String email, String password) {
//     if(email!='' && password != ''){
//       return true;
//     }else{
//       Get.snackbar("Error", "Fields cannot be empty",backgroundColor: Colors.red);
//       return false;
//     }
//   }
// }
