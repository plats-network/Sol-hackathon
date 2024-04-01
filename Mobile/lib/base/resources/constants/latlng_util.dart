import 'dart:math' as Math;

double getDistanceFromLatLonInM(
    double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
  var R = 6371 * 1000; // Radius of the earth in m
  var dLatitude = deg2rad(endLatitude - startLatitude); // deg2rad below
  var dLongitude = deg2rad(endLongitude - startLongitude);
  var a = Math.sin(dLatitude / 2) * Math.sin(dLatitude / 2) +
      Math.cos(deg2rad(startLatitude)) *
          Math.cos(deg2rad(endLatitude)) *
          Math.sin(dLongitude / 2) *
          Math.sin(dLongitude / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c; // Distance in km
  return d;
}

double deg2rad(deg) {
  return deg * (Math.pi / 180);
}
