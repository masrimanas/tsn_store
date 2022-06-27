import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const primaryColor = Color(0xff4338CA);
    const accentColor = Color(0xffffffff);

    const double borderRadius = 8;

    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  const Size.fromWidth(double.maxFinite)),
              elevation: MaterialStateProperty.all(0),
              alignment: Alignment.center,

              // padding: MaterialStateProperty.all(
              //     const EdgeInsets.fromLTRB(100, 8, 100, 8)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
              )),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: accentColor, fontSize: 16),
          ),
        ));
  }
}
