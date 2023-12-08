class SocketKeys {
  static String socketUrl = 'http://202.164.42.227:9898/';

  //Emiter/
  static String emitConnectUser = "connect_user";
  static String emitSendMessage = "send_message";
  static String emitGetUsers = "chat_list";
  static String emitChatHistories = "get_chat";
  static String emitClearChat = "clear_chat";
  static String emitReportUser = "report_user";
  static String emitReadUnread = "read_unread";
  // Tracking
  static String emitLiveTracking = "update_location";

  // Listener
  static String listenerConnectUser = "connect_user_listener";
  static String listenerSendMessage = "send_message_emit";
  static String listenerGetUsers = "chat_list";
  static String listenerChatHistories = "my_chat";
  static String listenerClearChat = "clear_chat_listener";
  static String listenerReportUser = "report_user_listener";
  static String listenerReadUnread = "read_data_status";
  static String listenerLiveTracking = "update_location_listener";
}

class MessageType {
  static String text = '1';
  static String image = '2';
  static String file = '3';
}
