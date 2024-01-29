class AppCore {
  static String productSizeText(List<String> list) {
    String sizeText = "";
    for (int i = 0; i < list.length; i++) {
      if (i != 0) {
        sizeText += "/";
      }
      sizeText += list[i];
    }
    return sizeText;
  }
}
