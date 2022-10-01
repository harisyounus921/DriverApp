// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   static String id = "registration_screen";
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen>
//     with SingleTickerProviderStateMixin{
//   AnimationController controller;
//   Animation animation;
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       duration: Duration(seconds: 5),
//       vsync: this,
//       // upperBound: 100.0,
//     );
//
//     animation = ColorTween(begin: Color(0xFF3E2A74), end: Color(0xFF5F4ECF))
//         .animate(controller);
//
//     controller.forward();
//     controller.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//   final _auth =FirebaseAuth.instance;
//   bool showSpinner=false;
//   final emailcontroller=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: animation.value,
//       body:ModalProgressHUD(
//         inAsyncCall: showSpinner,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children:[
//               Flexible(
//                 child: Hero(
//                   tag: "hero",
//                   child: Container(
//                     height: 200.0,
//                     child: Image.asset('assets/logoo.jpg'),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 48.0,
//               ),
//               TextField(
//                   textAlign: TextAlign.center,
//                   keyboardType: TextInputType.emailAddress,
//                   onChanged: (value) {},
//        ),
//               SizedBox(
//                 height: 8.0,
//               ),
//               TextField(
//                   textAlign: TextAlign.center,
//                   obscureText: true,
//                   onChanged: (value) {
//                   },),
//               SizedBox(
//                 height: 24.0,
//               ),
//               ElevatedButton(
//                 onPressed: ()async{
//                   try {
//                        final newuser = await _auth.createUserWithEmailAndPassword(
//                         email: email, password: paswords);
//                     // .then((value) async {
//                     User? user = FirebaseAuth.instance.currentUser;
//
//                     await FirebaseFirestore.instance.collection("account").doc(user?.uid).set({
//                       'email': email,
//                       'password':paswords,
//                       "id":user.uid,
//                       'picture':"https://firebasestorage.googleapis.com/v0/b/fir-withandroid-109ab.appspot.com/o/image_picker7517537375946758381.png?alt=media&token=b9bd8513-1e22-4315-a4f0-4b0da2c3072e",
//                     });
//                     if(newuser!=null){
//                       //Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification()));
//
//                     }
//                     setState(() {
//                       showSpinner=false;
//                     });
//                   }
//                   catch(e){
//                     print(e);
//                   }
//                 }, child: null,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
