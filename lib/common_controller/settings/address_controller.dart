import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/model/g_place_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class AddressController extends GetxController {
  var googleSearchAddress = <PlaceResults>[].obs;
  var googleSearching = false.obs;
  var googleSearchQuery = TextEditingController(text: '');

  searchGooglePlaces() async {
    await ApiRequests.gPlaceSearch(
      googleSearchQuery.text.trim(),
      addresses: (addresses) {
        googleSearchAddress.value = addresses;
      },
      loading: (loading) {
        googleSearching.value = loading;
      },
    );
  }
}
