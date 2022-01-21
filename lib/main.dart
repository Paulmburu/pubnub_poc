import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pubnub/pubnub.dart';
import 'package:pubnub_sample_app/chat_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  var pubnub = PubNub(
      defaultKeyset: Keyset(
          subscribeKey: dotenv.env['PUBNUB_SUBSCRIBE_KEY']!,
          publishKey: dotenv.env['PUBNUB_PUBLISH_KEY'],
          uuid: UUID(dotenv.env['PERSONAL_UUID']!)));

  // Subscribe to a channel
  var subscription = pubnub.subscribe(channels: {'Channel-Group'});

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
      home:
          // GroupsPage(
          //   pubnub: pubnub,
          // ),
          ChatPage(
        title: 'Pubnub Chat App',
        pubnub: pubnub,
        subscription: subscription,
      ),
    );
  }
}
