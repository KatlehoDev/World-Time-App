
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime; // true or false if daytime or not

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
    this.time = '',
    this.isDayTime = true,
  });

  // FUNCTION TO GET TIME
  Future<void> getTime() async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(
              'https://worldtime.timezone.io/api/timezone/$url',
            ),
          )
          .timeout(const Duration(seconds: 10));

      // Check if the request was successful
      if (response.statusCode != 200) {
        throw Exception('Request failed: ${response.statusCode}');
      }

      // Convert JSON text into a Dart Map
      Map data = jsonDecode(response.body);

      // Get the datetime and UTC offset from the API
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      // Convert the String into a DateTime object
      DateTime now = DateTime.parse(datetime);

      // Convert the UTC offset into hours and minutes
      final sign = offset.startsWith('-') ? -1 : 1;
      final parts = offset.substring(1).split(':');
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);

      now = now.add(
        Duration(
          minutes: sign * (hours * 60 + minutes),
        ),
      );

      // Check if it is daytime
      isDayTime = now.hour > 6 && now.hour < 20;

      // Format the time, e.g. 5:30 PM
      time = DateFormat.jm().format(now);

      print('Time successfully fetched: $time');
    } catch (e) {
      print('Error caught: $e');
      time = 'Could not get time';
    }
  }
}

// Create a WorldTime object
WorldTime katleho = WorldTime(
  location: 'Bloemfontein',
  flag: 'southafrica.png',
  url: 'Africa/Johannesburg',
);
