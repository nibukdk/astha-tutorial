import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TemplesUtils {
  // Base url for google maps nearbysearch
  static const String _baseUrlNearBySearch =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
  // get api key
  final String _placesApi = dotenv.env['GMAP_PLACES_API_KEY'] as String;

  // Create a method that'll parse complete url and return it using http package
  Uri searchUrl(LatLng userLocation) {
    // Create variables that'll pass maps API parmas as string
    final api = "&key=$_placesApi";

    final location =
        "location=${userLocation.latitude},${userLocation.longitude}";
    const type = "&type=hindu_temple";
    // Closest first
    const rankBy = "&rankby=distance";
    // Parse uri to get a new uri object
    final url =
        Uri.parse(_baseUrlNearBySearch + location + rankBy + type + api);

    return url;
  }
}
