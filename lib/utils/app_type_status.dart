class ProductType {
  static String biding = "Auction";
  static String fixedPrice = "Fix Price";
}

class TypeOfProduct {
  static int fixed = 1; // For ProductType-> Physical(Fixed Price)
  static int share = 2; // For Share product
  static int bid = 3; // For ProductType-> Physical(Biding)
}

class NotificationType {
  static int oneToOneChat = 1; // For one to one chat
  static int groupChat = 2; // For group chat
}

class ProductApproval {
  static int pending = 0;
  static int accepted = 1;
  static int rejected = 2;
}
