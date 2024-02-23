import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/model/settings/address_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';

class AddressController extends GetxController {
  var loadingData = false.obs;
  var addresses = <AddressModel>[].obs;
  // Selected Address
  var selectedAddress = Rx<AddressModel?>(null);

  getAddresses() async {
    await ApiRequests.getAddresses(data: (data) {
      addresses.value = data;
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  //--------------------------------------------
  var location = TextEditingController(text: '');
  var cordinates = Rx<LatLng?>(null);
  var refreshMap = false.obs;

  var street = TextEditingController(text: '');
  var houseNo = TextEditingController(text: '');
  var landmark = TextEditingController(text: '');

  clearFields() {
    location.clear();
    cordinates.value = null;
    street.clear();
    houseNo.clear();
    landmark.clear();
  }

  initialFields({
    required String location,
    required String latitude,
    required String longitude,
    required String street,
    required String houseNo,
    required String landMark,
  }) {
    this.location.text = location;
    cordinates.value = LatLng(double.parse(latitude), double.parse(longitude));
    this.street.text = street;
    this.houseNo.text = houseNo;
    landmark.text = landMark;
  }

  saveAddress() async {
    if (validation()) {
      bool success = await ApiRequests.addAddress(
          location: location.text.trim(),
          latitude: (cordinates.value?.latitude).toString(),
          longitude: (cordinates.value?.longitude).toString(),
          street: street.text.trim(),
          houseNo: houseNo.text.trim(),
          landMark: landmark.text.trim());

      if (success) {
        AppPrint.all("Add address successfully!");
        getAddresses();
        Get.back();
        clearFields();
      }
    }
  }

  editAddress(String addressId) async {
    if (validation()) {
      bool success = await ApiRequests.updateAddress(
          addressId: addressId,
          location: location.text.trim(),
          latitude: (cordinates.value?.latitude).toString(),
          longitude: (cordinates.value?.longitude).toString(),
          street: street.text.trim(),
          houseNo: houseNo.text.trim(),
          landMark: landmark.text.trim());
      if (success) {
        AppPrint.all("Update address successfully!");
        getAddresses();
        Get.back();
        clearFields();
      }
    }
  }

  deleteAddress(String addressId) async {
    bool success = await ApiRequests.deleteAddress(addressId);
    if (success) {
      AppPrint.all("Delete address successfully!");
      Get.back();
      getAddresses();
    }
  }

  validation() {
    if (location.text.trim() == '') {
      AppToast.show("Please add address");
      return false;
    }
    if (cordinates.value == null) {
      AppToast.show("Please add address");
      return false;
    }
    if (street.text.trim() == '') {
      AppToast.show("Please enter street");
      return false;
    }
    if (houseNo.text.trim() == '') {
      AppToast.show("Please enter house number");
      return false;
    }
    if (landmark.text.trim() == '') {
      AppToast.show("Please enter landmark");
      return false;
    }
    return true;
  }
}
