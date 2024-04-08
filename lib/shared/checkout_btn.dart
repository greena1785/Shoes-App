import 'package:flutter/material.dart';
import 'package:shoes_app/shared/appstyle.dart';


class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key, this.onTap, required this.label,
  });
  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          height: 35,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Center(
            child: Text(
              label,
              style: appstyle(20, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
