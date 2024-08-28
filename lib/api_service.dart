import 'dart:convert';
import 'package:cartgeek_aasignment/models/package_model.dart';
import 'package:http/http.dart' as http;
import 'models/current_booking_model.dart';

Future<List<Package>> fetchPackages() async {
  final response = await http.get(
    Uri.parse('https://www.cgprojects.in/lens8/api/dummy/packages_list'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['response'];
    return data.map((json) => Package.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load packages');
  }
}

Future<List<CurrentBooking>> fetchCurrentBooking() async {
  final response = await http.get(
    Uri.parse('https://www.cgprojects.in/lens8/api/dummy/current_booking_list'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['response'];
    return data.map((json) => CurrentBooking.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load current bookings');
  }
}
