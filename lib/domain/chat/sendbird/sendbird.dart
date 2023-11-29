import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class SendBird{

  static void init() {
    SendbirdChat.init(appId: "C205A820-1D97-4BFB-BB29-E1B2DE6C4FAF");
    debugPrint("sendBird inited!");
  }

  static Future<User?> connectByUserId(String userId) async {
    try{
      final user = await SendbirdChat.connect(userId, nickname: userId);
      debugPrint("sendBird connected by userId!");
      return user;
    }catch (e) {
      debugPrint("$e");
      return null;
    }        
  }

  static Future<GroupChannel?> createGroupChat(String channelUrl, List<String> userIds) async {
    try{
      final params = GroupChannelCreateParams()
      ..userIds = userIds
      ..channelUrl = channelUrl
      ..isPublic = true;
    
      final groupChannel = await GroupChannel.createChannel(params);
      return groupChannel;
    } catch (e) {
      debugPrint("e");  
    }

    return null;
  }

  static Future<GroupChannel?> getGroupChat(String channelUrl) async {
    try{
      final groupChannel = await GroupChannel.getChannel(channelUrl);

      return groupChannel;
    } catch (e) {
      debugPrint("$e");
    }

    return null;
  }

  static Future<UserMessage?> sendToGroupChat(GroupChannel groupChannel, String msg) async {
    try{
      final params = UserMessageCreateParams(message: msg);
    
      final message = groupChannel.sendUserMessage(params, handler:(message, e){
        if(e != null){
          debugPrint("$e");
        }
      });

      return message;

    } catch (e) {
      debugPrint("$e");
    }
    
    return null;
  }

  static void eventHandlerInit({required Function callBack}) {
    SendbirdChat.addChannelHandler('MyGroupChannelHandler', MyGroupChannelHandler(callBack: callBack));
  }

  static void eventHandlerDispose() {
    SendbirdChat.removeChannelHandler('MyGroupChannelHandler');
  }

  static Future<List<BaseMessage>?> getMessages(String channelUrl) async {
    try{
      final query = PreviousMessageListQuery(
        channelType: ChannelType.group, 
        channelUrl: channelUrl
      );

      final messages = await query.next();      
      return messages;

    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  static Future<void> setScheduledMessage(GroupChannel groupChannel, String msg, DateTime time) async {
    final params = ScheduledUserMessageCreateParams(
      message: "timeToGetBack_@@_$msg", 
      scheduledAt: time.millisecondsSinceEpoch,
    );

    try{
      final msg = await groupChannel.createScheduledUserMessage(params);
      
    } catch (e) {
      debugPrint("$e");
    }
  }

/////////////////////////////////////////////////////////////////
  static Future<OpenChannel?> createOpenChat({String? channelUrl}) async {
    late final openChannel;
    try{
      if(channelUrl == null){
        openChannel = await OpenChannel.createChannel(OpenChannelCreateParams());
      }else{
        final url2 = channelUrl;
        OpenChannelCreateParams params = OpenChannelCreateParams();
        params.channelUrl = url2;
        openChannel = await OpenChannel.createChannel(params);
      }
      
      debugPrint("sendBird created openChannel!");
      return openChannel;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  static Future<OpenChannel?> getOpenChat(String channelUrl) async {
    late OpenChannel? openChannel;
    final url2 = channelUrl;
    debugPrint("00 $url2");

    try{
      openChannel = await OpenChannel.getChannel(url2);
      debugPrint("$openChannel");
      print(openChannel.channelUrl);
      return openChannel;
    } catch (e){
      debugPrint("$e");
    }
    
    return null;
  }

  static Future<OpenChannel?> enterOpenChat(String channelUrl) async {
    try{
      final openChannel = await OpenChannel.getChannel(channelUrl);
      debugPrint("sendBird got openChannel!");
      await openChannel.enter();
      debugPrint("sendBird entered to openChannel!");
      return openChannel;
    } catch (e){
    }
    return null;
  }

  static UserMessage? sendToOpenChat(OpenChannel openChannel, String msg) {
    try{
      final params = UserMessageCreateParams(message: msg)
        ..data = "DATA0"
        ..customType = "custom??";
      
      final message = openChannel.sendUserMessage(params, handler: (message, e) {
        debugPrint("sended msg!");  
      });
      return message;

    } catch (e) {

    }

    return null;
  }

}

class MyGroupChannelHandler extends GroupChannelHandler {

  Function callBack;
  MyGroupChannelHandler({required this.callBack});

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // Received a new message.
    debugPrint("aaaa");
    callBack();
  }
}

