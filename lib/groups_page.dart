import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pubnub/pubnub.dart';
import 'package:pubnub_sample_app/utils.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key, required this.pubnub}) : super(key: key);

  final PubNub pubnub;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  void initState() {
    super.initState();
    fetchSubscribedChannels();
  }

  fetchSubscribedChannels() async {
    Set<String> subscribedGroups = widget.pubnub
        .getSubscribedChannelsForUUID((UUID(dotenv.env['PERSONAL_UUID']!)));
  }

  List<String> groups = <String>['Group1', 'another group', 'the group'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                itemCount: groups.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showSnackbar(context, groups[index]);
                      },
                      child: Text(
                        groups[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SendMessageWidget(
            //     onChanged: (String value) {
            //       // newMessage = value;
            //     },
            //     onTap: () {
            //       // sendMessage(widget.pubnub);
            //       // getGroupMembers(widget.pubnub);
            //       // setGroupMembers(widget.pubnub);
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
