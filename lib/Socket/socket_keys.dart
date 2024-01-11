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
  static String listenerBlockUser = "block_user_listener";
  static String listenerClearChat = "clear_chat_listener";

  /// Biding Socket Keys Emit
  static String emitAddBid = "add_bid";
  static String emitLastBid = "last_bid";
  static String emitBidOver = "over_bid";

  /// Biding Socket Keys Listener
  static String listenerAddBid = "add_bid";
  static String listenerLastBid = "last_bid";
  static String listenerBidOver = "over_bid";

  /// Share Product
  // Emiter
  static String emiterGetShareProductData = "viewSingleProduct";
  static String emiterPurchaseShare = "purchase_share";
  // Listener
  static String listenerGetShareProductData = "viewSingleProduct";
  static String listenerPurchaseShare = "purchase_share";

  /// Group Chat
  // Emiter
  static String emiterSendMessageGroup = "send_message_group";
  static String emiterGroupUsersList = "user_constant_list_group";
  static String emiterGroupChatHistories = "users_chat_list_group";
  // Listener
  static String listenerSendMessageGroup = "send_message_group";
  static String listenerGroupUsersList = "user_constant_list_group";
  static String listenerGroupChatHistories = "users_chat_list_group";
}

class MessageType {
  static String text = '0';
  static String image = '2';
  static String video = '3';
}
