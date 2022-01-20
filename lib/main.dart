import 'package:flutter/material.dart';
import 'package:pubnub/pubnub.dart';
import 'package:pubnub_sample_app/chat_page.dart';

void main() async {
  // initPubNub();

  var pubnub = PubNub(
      defaultKeyset: Keyset(
          subscribeKey: 'sub-c-e1d4d106-7900-11ec-87be-4a1e879706fb',
          publishKey: 'pub-c-2fb0426f-42dd-4a18-8b42-87231cf5284b',
          uuid: const UUID(
              'sec-c-ZjY1NDgxNDYtZTYzOS00ZmQ5LTkzNTMtMGY1Mzc5NzcxYjUw')));

  // Subscribe to a channel
  var subscription = pubnub.subscribe(channels: {'Channel-anotherGroup'});

  await Future.delayed(const Duration(seconds: 3));

  // var history = channel.messages();
  // var count = await history.count();
  runApp(MyApp(
    pubnub: pubnub,
    subscription: subscription,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.pubnub,
    required this.subscription,
  }) : super(key: key);

  final PubNub pubnub;
  final Subscription subscription;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pubnub Chat App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: ChatPage(
        title: 'Pubnub Chat App',
        pubnub: pubnub,
        subscription: subscription,
      ),
    );
  }
}
