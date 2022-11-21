import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/shopapp/cubit/cubit.dart';
import '../../modules/shopapp/loginscreen/login.dart';
import '../network/local/sharred.dart';

Widget textfield(
    {
      required TextInputType InputType,
      required TextEditingController Controller,
      required String labeltext,
      required Color labelStyle,
      dynamic prefixicon,
       IconData? sufixicon,
      String validatotText = 'must be enter !',
      bool isPassword = false,
       Function()?  ontap ,
       Function(String)?  onChange ,
      dynamic suffixPressed,
    }) =>
    TextFormField(
      onChanged: onChange,
      validator: (dynamic value) {
        if (value.isEmpty) {
          return validatotText;
        }
        return null;
      },
      obscureText: isPassword,
      onTap: ontap ,
      controller: Controller,
      keyboardType: InputType,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: TextStyle(
          color: labelStyle,
        ),
        prefixIcon: prefixicon != null ? Icon(prefixicon, color: labelStyle,) : null,
        suffixIcon: sufixicon != null ? IconButton(icon: Icon(sufixicon), color: labelStyle, onPressed: suffixPressed) : null,
      ),
    );
Widget buttom(
    {
      final double width = double.infinity,
      required final Function() onpressed,
      final double height = 50.0,
      required final String text,
      final Color textcolor = Colors.white,
      final double textSize = 20.0,
      final MaterialColor bodycolor = Colors.blue,
    }) => Container(
      width: width,
      height: height,
      child: MaterialButton(
        color: bodycolor,
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: textcolor,
          ),
        ),
      ),
    );



/*Widget Listt(news,context)=> InkWell(
  child:  Padding(
      padding: const EdgeInsetsDirectional.all(20.0),
      child: Row(
        children: [
          Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage('${news['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      '${news['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${news['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
  onTap: (){
    Navigator.push(context, MaterialPageRoute (
      builder: (BuildContext context) =>Webview(news['url']),
    ),);
  },
);*/

void toast({
  required String massage,
  required bool IsError
})
{
  Fluttertoast.showToast(
      msg: massage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: IsError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
  );
}

void SignOut(context){
  Sharred.delete(key: 'Token').then((value) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => Login()),
            (route) {
          return false;
        });
  });
}

void NavigatorAndRemove({required context,required Widget page}){
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page),
          (route) {
        return false;
      });
}
void NavigatorPush({required context,required Widget page}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => page));
}

Widget BuildItem(model,context) {
  bool? check = HomeCubit.get(context).favourite[model.id];
  return Container(
      color: Colors.white,
      height: 150.0,
      width: double.infinity,
      child:Padding(
          padding: const EdgeInsetsDirectional.all(20.0),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: 150.0,
                    height: 150.0,
                  ),
                ],
              ),
              SizedBox(
                width : 10.0,
              ),
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue
                          ),
                        ),
                        Spacer(),
                         TextButton(
                             onPressed: (){
                               HomeCubit.get(context).ChangeFavourite(model.id);
                               },
                             child: CircleAvatar(
                                 radius: 20.0,
                                 backgroundColor: check! ?
                                 Colors.blue: Colors.grey,
                                 child: Icon(Icons.favorite_border,
                                   size: 14.0,
                                   color: Colors.white,
                                 )
                             )
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
      )
  );
}