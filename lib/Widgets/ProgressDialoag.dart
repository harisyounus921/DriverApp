import 'package:flutter/material.dart';

class ProgressDialloag extends StatefulWidget {
  var message;
  ProgressDialloag({this.message});

  @override
  State<ProgressDialloag> createState() => _ProgressDialloagState();
}

class _ProgressDialloagState extends State<ProgressDialloag> {
  @override
  Widget build(BuildContext context) {
    String message=widget.message;
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              SizedBox(width: 6,),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),),
              const SizedBox(width: 6,),
              Text("Processing Please Wait......"),
            ],
          ),
        ),
      ),
    );
  }
}
