import 'package:drive_app/Global/GlobalPage.dart';
import 'package:drive_app/main_screen/main_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Splash/splash_screen.dart';

class CarInfoScreen extends StatefulWidget {
  CarInfoScreen({Key? key}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  bool showSpinner=false;
  TextEditingController CarNumbercontoller=TextEditingController();
  TextEditingController CarModelcontoller=TextEditingController();
  TextEditingController CarColorcontoller=TextEditingController();

  List<String> carTypeList= ["Uber-x","Uber-go","bike"];
  String? SelectedCarType;

  void Validation(){
    if(CarColorcontoller.text.isEmpty){
      Fluttertoast.showToast(msg: "Car Color is Required.");
    }else if(CarModelcontoller.text.isEmpty){
      Fluttertoast.showToast(msg: "Car Model is Required.");
    }else if(CarNumbercontoller.text.isEmpty){
      Fluttertoast.showToast(msg: "Car Number is Required.");
    }else if(SelectedCarType == null){
      Fluttertoast.showToast(msg: "Car Type is Required.");
    }else{
      SaveCarInfo();
    }
  }

  void SaveCarInfo(){
    Map driverCarInfoMap=
    {
      'car_color':CarColorcontoller.text.trim(),
      'car_number':CarNumbercontoller.text.trim(),
      'car_model':CarModelcontoller.text.trim(),
      'type':SelectedCarType,
    };
    DatabaseReference driverRef=FirebaseDatabase.instance.ref().child("driver");
    driverRef.child(crrentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car Details has been Saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (_)=>MySplashScreen()));

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

                Center(child: Text("Write Car Details",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey),)),

                SizedBox(height: 30,),

                TextField(
                  controller: CarNumbercontoller,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " CAR NUMBER",
                    hintText: " Enter Your Car Number",
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

                TextFormField(
                  controller: CarModelcontoller,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " CAR MODEL",
                    hintText: " Enter Your Car Model",
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

                TextField(
                  controller: CarColorcontoller,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: " CAR COLOR",
                    hintText: " Enter Your Car Color",
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

              Center(
                child: DropdownButton(
                  dropdownColor: Colors.white24,
                  iconSize: 20,
                  icon: Icon(Icons.add),
                  hint: const Text("Please Chouse Caar Type"), style: const TextStyle(fontSize: 14, color: Colors.grey,),
                  value: SelectedCarType,
                  onChanged: (newValue){
                    setState(() {
                      SelectedCarType=newValue.toString();
                    });
                  },
                  items: carTypeList.map((car) {
                    return DropdownMenuItem(value: car,child: Text(car,style: TextStyle(color: Colors.grey,)));
                  }).toList(),
                ),
              ),
                SizedBox(height: 30,),
                _LogInSignUpButton(title: "Save Now", onTap: (){Validation();})
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
