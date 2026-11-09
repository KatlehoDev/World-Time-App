
import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  Future<void> setupWorldTime() async {

    WorldTime katleho = WorldTime(
      location: 'Bloemfontein',
      flag: 'southafrica.png',
      url: 'Africa/Johannesburg',
    );

    try {
      await katleho.getTime();

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'location': katleho.location,
          'time': katleho.time,
          'flag': katleho.flag,
          'isDayTime': katleho.isDayTime,
        },
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load time: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 237, 237),
      body: const Center(
        child: SpinKitThreeInOut(
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }
}
