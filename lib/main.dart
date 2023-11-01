import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ListingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyD1WRZAPpe4mwUDo9g2t9ThabUOvGty1ng",
    authDomain: "software-project-824b6.firebaseapp.com",
    projectId: "software-project-824b6",
    storageBucket: "software-project-824b6.appspot.com",
    messagingSenderId: "965960343499",
    appId: "1:965960343499:web:1cc5564de11950d55b204e",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListingScreen(),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   CollectionReference user = FirebaseFirestore.instance.collection('user');
//   late String textNote;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 textNote = value;
//               },
//               decoration: InputDecoration(hintText: 'Enter a note'),
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   await user
//                       .add({'name': 'umar', 'age': 23, 'notes': textNote}).then(
//                           (value) => print('User added'));
//                 },
//                 child: Text('Submit Data'))
//           ],
//         )
        
//         );
//   }
// }
