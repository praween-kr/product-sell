class ProductType {
  static String biding = "Auction";
  static String fixedPrice = "Fix Price";
}

class TypeOfProduct {
  static int fixed = 1; // For ProductType-> Physical(Fixed Price)
  static int share = 2; // For Share product
  static int bid = 3; // For ProductType-> Physical(Biding)
}

class ProductApproval {
  static int pending = 0;
  static int accepted = 1;
  static int rejected = 2;
}

class NotificationType {
  static int oneToOneChat = 1; // For one to one chat
  static int groupChat = 2; // For group chat
  static int bidStarted = 4; // Bid started
  static int productApprouved = 5; // Product approuved by admin
}

class ProductShippingStatus {
  // 0 shipping pending, 1 for shipping started and 2 for shipped to buyer
  static int pending = 0;
  static int shippedFromSeller = 1;
  static int receiveByBuyer = 2;
}

class PaymentStatus {
  static String success = "succeeded";
}
