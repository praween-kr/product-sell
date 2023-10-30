class GooglePlaces {
  List<PlaceResults>? results;
  String? status;

  GooglePlaces({this.results, this.status});

  GooglePlaces.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <PlaceResults>[];
      json['results'].forEach((v) {
        results!.add(PlaceResults.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class PlaceResults {
  String? address;
  Geometry? cordinates;

  PlaceResults({this.address, this.cordinates});

  PlaceResults.fromJson(Map<String, dynamic> json) {
    address = json['formatted_address'];
    cordinates =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_address'] = address;
    if (cordinates != null) {
      data['geometry'] = cordinates!.toJson();
    }
    return data;
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }

    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
