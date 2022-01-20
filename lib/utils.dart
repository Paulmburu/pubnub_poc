import 'package:flutter/material.dart';
import 'package:pubnub/pubnub.dart';

Future<bool> publishMessage({
  required PubNub pubnub,
  required String message,
}) async {
  // Channel abstraction for easier usage
  var channel = pubnub.channel('Channel-anotherGroup');

  PublishResult publishResult = await channel.publish({'message': message});
  return !publishResult.isError;
}

Future<bool> deleteMessage({
  required PubNub pubnub,
  required String message,
}) async {
  // Channel abstraction for easier usage
  var channel = pubnub.channel('Channel-anotherGroup');

  // await channel.deleteMessageAction(messageTimetoken: messageTimetoken, actionTimetoken: actionTimetoken)

  PublishResult publishResult = await channel.publish({'message': message});
  return !publishResult.isError;
}

void getGroupMembers(PubNub pubnub) async {
  ChannelMembersResult channelMembersResult =
      await pubnub.objects.getChannelMembers('Channel-anotherGroup');

  channelMembersResult.metadataList?.forEach((element) {
    print('uuid->' + element.uuid.id);
  });
  // return
}

void setGroupMembers(PubNub pubnub) async {
  ChannelMembersResult channelMembersResult =
      await pubnub.objects.setChannelMembers('Channel-anotherGroup', [
    ChannelMemberMetadataInput(
      'john_doe_1',
      custom: {'trialPeriod': false},
    ),
    ChannelMemberMetadataInput(
      'alexa_doe',
      custom: {'trialPeriod': false},
    ),
    ChannelMemberMetadataInput(
      'siri',
      custom: {'trialPeriod': false},
    )
  ]);

  channelMembersResult.metadataList?.forEach((element) {
    print('uuid->' + element.uuid.id);
  });
  // return
}

void removeGroupMember(PubNub pubnub, String uuid) async {
  ChannelMembersResult channelMembersResult = await pubnub.objects
      .removeChannelMembers('Channel-anotherGroup', {'John Doe'});
  channelMembersResult.metadataList?.forEach((element) {
    print('uuid->' + element.uuid.toString());
  });
}

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}
