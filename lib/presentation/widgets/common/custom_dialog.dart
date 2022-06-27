import 'package:flutter/material.dart';
import 'package:tsn_store/presentation/widgets/common/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String desc;
  final CustomButton button;
  final String url;

  const CustomDialog({
    Key? key,
    required this.button,
    required this.desc,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Image.network(url),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 3.5,
              ),
              Expanded(
                child: Text(desc,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w300)),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: button,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
