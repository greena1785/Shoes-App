import 'package:flutter/material.dart';
import 'package:shoes_app/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({super.key, this.onPress, required this.buttonClr, required this.label});
  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPress,
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width*0.240,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: buttonClr, style: BorderStyle.solid,
          ),
              borderRadius: const BorderRadius.all(Radius.circular(9))
        ),
        child: Center(
            child: Text(label,style: appstyle(13, buttonClr, FontWeight.w600),
            )),
      ),
    );
  }
}
