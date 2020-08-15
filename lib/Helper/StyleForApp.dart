

import 'package:flutter/material.dart';

import '../constants.dart';

OutlineInputBorder getOutLineBorder({double width,Color color,double radius}){
  return OutlineInputBorder(
      borderSide: BorderSide(
          width: width,
          color:color,

      ),
    borderRadius: BorderRadius.circular(radius)
  );
}



InputDecoration getInputDecorationHassan({String hint,String label,Widget icon}){

  if(icon==null)
    icon=Icon(Icons.person,color: kPrimaryColor,);
    return InputDecoration(

      prefixIcon: IconButton(onPressed: (){},icon:icon,),
    alignLabelWithHint: true,
    hintText: hint==null?"":hint,
    labelText: label==null?"":label,
    border: OutlineInputBorder(
      borderRadius:BorderRadius.circular(30),),
    focusedBorder: getOutLineBorder(width: 1,color:kPrimaryColor,radius:30),
    enabledBorder: getOutLineBorder(width: 1.5,color:kPrimaryLightColor,radius:30),
    errorBorder: getOutLineBorder(width: 1.5,color:Colors.red,radius:30),
    focusedErrorBorder:getOutLineBorder(width: 1.5,color:Colors.red,radius:30),
);
}


InputDecoration getInputDecorationChat({String hint,String label}){

/*  if(icon==null)
    icon=Icon(Icons.send,color: kPrimaryColor,);*/
  return InputDecoration(


  //  prefixIcon: IconButton(onPressed:press,icon:icon,),
    alignLabelWithHint: true,
    hintText: hint==null?"":hint,

    labelText: label==null?"":label,
    border: UnderlineInputBorder(
          borderSide: BorderSide(
          width: 1.5,
          color: kPrimaryColor
      )),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
      width: 1.5,
      color: kPrimaryColor
    )),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
        width: 1.5,
        color: kPrimaryColor
    )),

  );
}


InputDecoration getInputDecorationCountry({Widget myPrefix,String hint,String label} ){

  return InputDecoration(



    alignLabelWithHint: true,
    hintText: hint==null?"":hint,
    labelText: label==null?"":label,
    prefix: myPrefix,
    border: OutlineInputBorder(
      borderRadius:BorderRadius.circular(30),),
    focusedBorder: getOutLineBorder(width: 1.5,color:kPrimaryColor,radius:30),
    enabledBorder: getOutLineBorder(width: 1.5,color:kPrimaryLightColor,radius:30),
    errorBorder: getOutLineBorder(width: 1.5,color:Colors.red,radius:30),
    focusedErrorBorder:getOutLineBorder(width: 1.5,color:Colors.red,radius:30),
  );
}

InputDecoration getInputDecorationPassword({String hint,String label,VoidCallback pressPrifix,Widget icon,bool obsecure}){

  return InputDecoration(
    alignLabelWithHint: true,
    hintText: hint==null?"":hint,
    labelText: label==null?"":label,
    border: OutlineInputBorder(
      borderRadius:BorderRadius.circular(30),),
    focusedBorder: getOutLineBorder(width: 1.5,color:kPrimaryColor,radius:30),
    enabledBorder: getOutLineBorder(width: 1.5,color:kPrimaryLightColor,radius:30),
    errorBorder: getOutLineBorder(width: 1.5,color:Colors.red,radius:30),
    focusedErrorBorder:getOutLineBorder(width: 1.5,color:Colors.red,radius:30),
    prefixIcon: obsecure?
    IconButton(onPressed: pressPrifix,icon:icon,iconSize: 20,color: kPrimaryColor,):
    IconButton(onPressed: pressPrifix,icon:icon,iconSize: 20,color: Colors.red,)
  );
}


const TextStyle NormalTextWhite= TextStyle(
   fontSize: 16,
    color: Colors.white,

   );

TextStyle getTextSyle(double size,Color color,{FontWeight fontWeight,bool underLine}){
  if(underLine==null)
    underLine=false;
  return TextStyle(
    fontSize: size,

    fontWeight: fontWeight==null?FontWeight.normal:fontWeight,
    color: color,
    decoration: underLine?TextDecoration.underline:TextDecoration.none
  );
}

