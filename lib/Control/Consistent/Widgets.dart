
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';

Widget defaultTextFormField({@required context,@required controller,@required TextInputType ?keybord,
  @required field_name,suffix,@required prefix,sucre,suffixfunction,Validator_funcation,
  onFieldSubmitted
})=>Container(
  width: MediaQuery.of(context).size.width*.9,
  height:MediaQuery.of(context).size.height*.1,
  child:   TextFormField(
    controller:controller,
    obscureText:sucre??false,
    onFieldSubmitted:onFieldSubmitted,
    keyboardType: keybord,
    validator: Validator_funcation?? (value){
      if (value!.isEmpty)
        return 'must be fill this field';
         return null;
    },
    decoration:InputDecoration(
      label: Text('$field_name'),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(width(context, .09))),
      suffixIcon: IconButton(onPressed:suffixfunction,icon: Icon(suffix)),
      prefixIcon: Icon(prefix),
    ),
  ),
);

void navigatorTO(context,page)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>page));

void navigatorTOAndRemove(context,page)=>Navigator.pushAndRemoveUntil(context,   MaterialPageRoute(builder: (context) =>page), (route) => false);

Widget defaultButton({@required context,@required function,@required widget,@required color})=>Container(
    width: width(context, .9),
    height: height(context, .077),
    decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(50),
    ),
    child: MaterialButton(
      onPressed:function,
      child: widget,
      color: color,
      height:height(context, .077),
      minWidth: width(context, .9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),));

Widget defaultTextButton({@required function,@required widget})=>TextButton(onPressed:function, child:widget);

void Show_toast({required String message,required Color color,}){
   Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 4,
  backgroundColor: color,
  textColor: Colors.white,
  fontSize: 16.0,
);
}