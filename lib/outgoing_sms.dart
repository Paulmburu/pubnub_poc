import 'package:flutter/material.dart';

class OutgoingSms extends StatelessWidget {
  const OutgoingSms({Key? key, required this.sms}) : super(key: key);
  final String sms;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
          color: Colors.amber,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            sms,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
