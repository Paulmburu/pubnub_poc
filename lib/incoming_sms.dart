import 'package:flutter/material.dart';

class IncomingSms extends StatelessWidget {
  const IncomingSms({Key? key, required this.sender, required this.sms})
      : super(key: key);
  final String sms;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
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
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  sender,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  sms,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
