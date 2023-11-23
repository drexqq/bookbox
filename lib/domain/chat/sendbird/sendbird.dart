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

  static Future<OpenChannel?> testCreate({String? channelUrl}) async {
    late final openChannel;
    try{
      if(channelUrl == null){
        openChannel = await OpenChannel.createChannel(OpenChannelCreateParams());
      }else{
        OpenChannelCreateParams params = OpenChannelCreateParams();
        params.channelUrl = channelUrl;
        openChannel = await OpenChannel.createChannel(params);
      }
      
      debugPrint("sendBird created openChannel!");
      return openChannel;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  // static Future<GroupChannel?> testCreateGroup(List<String> userIds, {String? channelUrl}) async {
  //   late final groupChannel;
  //   final params = GroupChannelCreateParams()
  //         ..userIds = userIds;
  //   try{
  //     if(channelUrl == null){
  //       groupChannel = await GroupChannel.createChannel(params);
  //     }else{
  //       groupChannel = await GroupChannel.createChannel(params, chan)
  //     }
  //   } catch (e) {

  //   }
  // }

  static Future<OpenChannel?> testEnter(String channelUrl) async {
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

  static UserMessage? testSend(OpenChannel openChannel, String msg) {
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