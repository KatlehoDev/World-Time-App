import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget{

  @override
  State<ChooseLocation> createState() => ChooseLocationState();
}

class ChooseLocationState extends State<ChooseLocation>{

   

  List<WorldTime> locations =
  [
    WorldTime(location: 'London', flag: 'usa.jpg', url: 'Europe/London'),
    WorldTime(location: 'Athens', flag: 'germany.jpg', url: 'Europe/Berlin'),
    WorldTime(location: 'Cairo', flag: 'greece.jpg', url: 'Europe/London'),
    WorldTime(location: 'Nairobi', flag: 'egypt.jpg', url: 'Europe/Cairo'),
    WorldTime(location: 'Chigaco', flag: 'spain.jpg', url: 'Europe/Madrid'),
    WorldTime(location: 'New York', flag: 'usa.jpg', url: 'Europe/New_York'),
    WorldTime(location: 'Seoul', flag: 'greece.jpg', url: 'Europe/Seoul'),
    WorldTime(location: 'Johannesburg', flag: 'southafrica.jpg', url: 'Europe/Bloemfontein'),
  ];

  void updateTime(index) async{
    WorldTime katleho = locations[index];
    await katleho.getTime();
    //Navigate to home screen
    Navigator.pop(context, {
      'location': katleho.location,
          'time': katleho.time,
          'flag': katleho.flag,
          'isDayTime': katleho.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context){
    //print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:AppBar(
        backgroundColor: Colors.blue,
        title:Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body:ListView.builder(
        itemCount : locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding:EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child:Card(
             child: ListTile(
             onTap:(){
             updateTime(index);
             },
             title:Text(locations[index].location),
             leading:CircleAvatar(backgroundImage: AssetImage('assets/${locations[index].flag}'),
             ),
             ),
            ),
          );
        }
        
        )
    );
  }
}