import 'dart:math';

class Utils {
  static const R = 6372.8; // In kilometers

  static double haversine(double lat1, double lon1, double lat2, double lon2) {
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    lat1 = _toRadians(lat1);
    lat2 = _toRadians(lat2);
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    // double c = 2 * asin(sqrt(a));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    // const d = R * c
    return R * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
