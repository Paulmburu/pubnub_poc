import 'package:pubnub/pubnub.dart';

void initPubNub() async {
  // Create PubNub instance with default keyset.
  var pubnub = PubNub(
      defaultKeyset: Keyset(
          subscribeKey: 'sub-c-e1d4d106-7900-11ec-87be-4a1e879706fb',
          publishKey: 'pub-c-2fb0426f-42dd-4a18-8b42-87231cf5284b',
          uuid: const UUID(
              'sec-c-ZjY1NDgxNDYtZTYzOS00ZmQ5LTkzNTMtMGY1Mzc5NzcxYjUw')));

  // Subscribe to a channel
  var subscription = pubnub.subscribe(channels: {'Channel-kqznu35ai'});

  subscription.messages.take(1).listen((envelope) async {
    print('PUBNUB->ENVELOPE' + envelope.payload);

    await subscription.dispose();
  });

  await Future.delayed(const Duration(seconds: 3));

  // Publish a message
  await pubnub.publish('Channel-kqznu35ai', {'message': 'My message!'});

  // Channel abstraction for easier usage
  var channel = pubnub.channel('Channel-kqznu35ai');

  await channel.publish({'message': 'Another message'});

  // Work with channel History API
  var history = channel.messages();
  var count = await history.count();

  print('PUBNUB->Messages on test channel: $count');
}
