import 'package:flutter/material.dart';

class Hompage extends StatelessWidget{
  final String email;
  const Hompage({Key? key,required this.email});
  @override
  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: Colors.teal,
     body: Column(
       children: [
         Center(child: Text("Heelooooo $email",style: TextStyle(fontSize: 30,color: Colors.pink),)),
       ],
     ),
   );
  }

}