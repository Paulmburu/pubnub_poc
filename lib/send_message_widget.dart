// Flutter imports:
import 'package:flutter/material.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({
    Key? key,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Type message here ..',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
          Row(
            children: <Widget>[
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //   color: Colors.blueGrey,
                  //   borderRadius: BorderRadius.circular(4),
                  // ),
                  child: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
