class SocketKeys {
  static String socketUrl = 'http://202.164.42.227:9898/';

  //Emiter/
  static String emitConnectUser = "connect_user";
  static String emitSendMessage = "send_message";
  static String emitGetUsers = "user_constant_list";
  static String emitChatHistories = "";
  static String emitClearChat = "";
  static String emitReportUser = "";
  static String emitReadUnread = "";

  // Listener
  static String listenerConnectUser = "connect_user_listener";
  static String listenerSendMessage = "send_message_emit";
  static String listenerGetUsers = "user_constant_chat_list";
  static String listenerChatHistories = "";
  static String listenerClearChat = "";
  static String listenerReportUser = "";
  static String listenerReadUnread = "";
  static String listenerLiveTracking = "";
}

class MessageType {
  static String text = '1';
  static String image = '2';
  static String file = '3';
}
