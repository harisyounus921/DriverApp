import 'package:drive_app/Signup/CarInfo.dart';
import 'package:drive_app/Widgets/ProgressDialoag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Global/GlobalPage.dart';
import '../Login/LoginPage.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showSpinner=false;
  TextEditingController Namecontoller=TextEditingController();
  TextEditingController Emailcontoller=TextEditingController();
  TextEditingController Paswordcontoller=TextEditingController();
  TextEditingController PhoneNumbercontoller=TextEditingController();

  void Validation(){
    if(Namecontoller.text.length<3){
      Fluttertoast.showToast(msg: "Name Must be Atleast 3 Characters.");
    }else if(!Emailcontoller.text.contains("@")){
      Fluttertoast.showToast(msg: "Email Address is NOT valid");
    }else if(PhoneNumbercontoller.text.isEmpty){
      Fluttertoast.showToast(msg: "Phone Number is Required.");
    }else if(Paswordcontoller.text.length<6){
      Fluttertoast.showToast(msg: "Password Must be Atleast 6 Characters.");
    }else{
      saveDriverInfoNow();
    }
  }

  void saveDriverInfoNow()async{
    showDialog(context: context,
        barrierDismissible: false,
        builder:(BuildContext c){
          return ProgressDialloag(message: "Processing Please Wait.....");
        });
    final User? firebaseUser=(
        await fAuth.createUserWithEmailAndPassword(
            email: Emailcontoller.text.trim(),
            password: Paswordcontoller.text.trim()
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error"+msg.toString());
        })
    ).user;
    if(firebaseUser!=null){
      Map driverMap=
          {
            'id':firebaseUser.uid,
            'name':Namecontoller.text.trim(),
            'email':Emailcontoller.text.trim(),
            'phone':PhoneNumbercontoller.text.trim(),
            'password':Paswordcontoller.text.trim()
          };
      DatabaseReference driverRef=FirebaseDatabase.instance.ref().child("driver");
      driverRef.child(firebaseUser.uid).set(driverMap);
      crrentFirebaseUser=firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (_)=>CarInfoScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/driverlogo.png'),
                ),
                SizedBox(height: 10,),

                Center(child: Text("Register as a Driver",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey),)),

                SizedBox(height: 30,),

                TextField(
                  controller: Namecontoller,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " NAME",
                    hintText: " Enter Your Name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ),

                SizedBox(height: 30,),

                TextFormField(
                  controller: Emailcontoller,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " EMAIL",
                    hintText: " Enter Your Email",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ),

                SizedBox(height: 30,),

                TextField(
                  controller: PhoneNumbercontoller,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " PHONE NUMBER",
                    hintText: " Enter Your Phone Number",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ),

                SizedBox(height: 30,),

                TextField(
                  controller: Paswordcontoller,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " PASSWORD",
                    hintText: " Enter Your Password",
                    //enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ),

                SizedBox(height: 30,),

                _LogInSignUpButton(title: "Signup", onTap: (){
                  Validation();
                }),

                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));},
                      child: Text("Already Have An Account? Login ",style: TextStyle(color: Colors.grey),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogInSignUpButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap;
  _LogInSignUpButton({required this.title,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 1.0,right: 1),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff1aa260),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(title)),
            ),
          ),
        ),
      );
  }
}
