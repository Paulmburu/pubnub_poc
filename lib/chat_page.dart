import 'package:flutter/material.dart';
import 'package:pubnub/pubnub.dart';
import 'package:pubnub_sample_app/incoming_sms.dart';
import 'package:pubnub_sample_app/outgoing_sms.dart';
import 'package:pubnub_sample_app/send_message_widget.dart';
import 'package:pubnub_sample_app/utils.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.title,
    required this.pubnub,
    required this.subscription,
  }) : super(key: key);

  final String title;
  final PubNub pubnub;
  final Subscription subscription;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    listenToMessages();
  }

  @override
  void dispose() {
    widget.subscription.dispose();
    super.dispose();
  }

  void listenToMessages() async {
    widget.subscription.messages.listen((envelope) async {
      addMessage(envelope);
      // print('PUBNUB->ENVELOPE' + envelope.payload);
      // print('PUBNUB->ENVELOPE' + envelope.uuid.toString());
    });
  }

  addMessage(Envelope envelope) {
    setState(() {
      messages.add(IncomingSms(
        sender: envelope.uuid.toString(),
        sms: envelope.payload['text'],
      ));
    });
  }

  String newMessage = '';
  List<Widget> messages = <Widget>[
    // const IncomingSms(sender: 'anonymous', sms: 'yoh'),
    // const OutgoingSms(sms: 'hello there'),
    // const IncomingSms(sender: 'anonymous', sms: 'hi'),
    // const OutgoingSms(sms: '...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: messages[index] is IncomingSms
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: messages[index],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SendMessageWidget(
                onChanged: (String value) {
                  newMessage = value;
                },
                onTap: () {
                  sendMessage(widget.pubnub);
                  // getGroupMembers(widget.pubnub);
                  // setGroupMembers(widget.pubnub);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage(
    PubNub pubnub,
  ) async {
    bool isSuccessful =
        await publishMessage(pubnub: pubnub, message: newMessage);

    if (isSuccessful) {
      setState(() {
        messages.add(OutgoingSms(sms: newMessage));
      });

      showSnackbar(context, 'Text sent successfully !');
      setState(() {
        newMessage = '';
      });
    } else {
      showSnackbar(context, 'an error occured !');
    }
  }
}
