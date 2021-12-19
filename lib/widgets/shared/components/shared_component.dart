import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/page_veiw_model.dart';
import 'package:shop_app/styles/colors.dart';

Widget defaultBoardingPage(PagesViewModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        // const SizedBox(
        //   height: 30.0,
        // ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );

void navagateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navagateToAndReplace(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function()? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      // onTap: () {
      //   onTap!();
      // },
      obscureText: isPassword,
      onChanged: (value) {
        // onChanged!(value);
      },
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.white)),
        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixClicked!();
                },
                icon: Icon(
                  suffix,
                  color: defaultColor,
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = defaultColor,
  bool isUpperCase = true,
  double radius = 20,
  required void Function() function,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

void showToast({message, col = Colors.red}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: col,
    textColor: Colors.white,
    fontSize: 16.0);
