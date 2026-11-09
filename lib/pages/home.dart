
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Map data = {};
  bool _isLoading = true;

  // 1. Runs when the Home screen is created.
  @override
  void initState() {
    super.initState();
    startLoading();
  }

  // 2. Wait for 5 seconds.
  Future<void> startLoading() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map) {
      data = arguments;
    }

    print(data);

    String bgImage = (data['isDayTime'] ?? true)
        ? 'daylight.jpg'
        : 'night.jpg';

    // 3. Display loading screen first.
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 4. Display actual content after 5 seconds.
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(
                    context,
                    '/location',
                  );

                  if (result is Map && mounted) {
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag'],
                      };
                    });
                  }
                },
                icon: const Icon(Icons.edit_location),
                label: const Text('Edit Location'),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'] ?? 'Unknown location',
                    style: const TextStyle(
                      fontSize: 22,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(data['time'] ?? 'Loading time...'),
            ],
          ),
        ),
      ),
    );
  }
}
