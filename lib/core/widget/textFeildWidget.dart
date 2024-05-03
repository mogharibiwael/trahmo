
import 'package:flutter/material.dart';
import 'package:trahmoo/core/style/app_colors.dart';

class TextFeildWidget extends StatefulWidget {
   TextFeildWidget({
     required this.label,
     required this.icon,
     required this.iconColor,
     required this.controller,
     required this.type,
     required this.isScure
  }) ;
  String label;
  IconData icon;
  Color iconColor;
  TextInputType type;
  TextEditingController controller;
  bool isScure;

  @override
  State<TextFeildWidget> createState() => _TextFeildWidgetState();
}
var checkIf=false;
var redBorder=false;
var _error=false;
class _TextFeildWidgetState extends State<TextFeildWidget> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textFieldColor,
      border:Border.all(color: _error && widget.controller.text.isEmpty  ? Colors.red : Colors.transparent)
    ),
      padding: EdgeInsets.symmetric(vertical: 10),
      height:_error?75: 64,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value){
          if (value == null || value.isEmpty) {

            setState(() {
              _error=true;
            });
            return 'Please enter some text';
          }else{
            if(widget.type==TextInputType.emailAddress){
              if(
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!)){

                return 'Please enter valid email';

              }
            }
            setState(() {
              redBorder=false;
            });
            return null;
          }
        },
        controller: widget.controller,
        keyboardType:widget.type ,
        obscureText: widget.isScure,
        autocorrect: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(vertical: 20.0,horizontal:10),
            label: Text(widget.label,style: TextStyle(fontSize: 15),),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            suffix:Icon(widget.icon,color:widget.iconColor,size: 30,)
        ),
      ),

    );
  }
}




class Test extends StatefulWidget{

 State<StatefulWidget> createState(){
    return TestState();
  }
}
class TestState extends State<Test>{

  Widget build(BuildContext context){
    return Container();
  }

}

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
