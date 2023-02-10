import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kangru/page/girdViewPage.dart';
import '../data/Location.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Denied');
    } else {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GridViewPage(
                lati: location.latitude,
                long: location.longitude,
              );
            },
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
