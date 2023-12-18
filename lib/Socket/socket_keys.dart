class SocketKeys {
  static String socketUrl = 'http://202.164.42.227:9898/';
  // static String socketUrl = 'http://192.168.1.210:9898/';

  //Emiter/
  static String emitConnectUser = "connect_user";
  static String emitDisconnectUser = "disconnect_user";
  static String emitSendMessage = "send_message";
  static String emitGetUsers = "user_constant_list";
  static String emitChatHistories = "users_chat_list";
  static String emitReadUnread = "read_unread";
  static String emitDeleteMsg = "delete_message";
  static String emitTyping = "stopTyping";
  //
  static String emitReportUser = "";
  static String emitBlockUser = "block_user";
  static String emitClearChat = "clear_chat";

  // Listener
  static String listenerConnectUser = "connect_user_listener";
  static String listenerDisconnectUser = "disconnect_listener";
  static String listenerSendMessage = "send_message_emit";
  static String listenerGetUsers = "user_constant_chat_list";
  static String listenerChatHistories = "users_chat_list_listener";
  static String listenerReadUnread = "read_unread_listner";
  static String listenerDeleteMsg = "delete_message_listener";
  static String listenerTyping = "stopTyping";
  //
  static String listenerReportUser = "";
  static String listenerBlockUser = "block_user_listener";
  static String listenerClearChat = "clear_chat_listener";
}

class MessageType {
  static String text = '0';
  static String image = '2';
  static String video = '3';
}
