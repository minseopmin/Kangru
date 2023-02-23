import 'package:flutter/material.dart';
import '../Component/appbar.dart';
import '../Component/card.dart';
import '../Model/cardItem.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

final cardItem = {
  "list": [
    {
      "image":
          "https://img.siksinhot.com/place/1621306337133097.jpeg?w=540&h=436&c=Y",
      "name": "신세계 떡볶이",
      "address": "명동",
      "phoneNumber": '010-4479-1429',
      "score": 4.5,
      "gScore": 4.2,
      "nScore": 4.7,
      "kScore": 4.0,
      "longitude": 126.984958,
      "latitude": 37.564407,
    },
    {
      "image":
          "https://live.staticflickr.com/7364/12693021913_468f3bbc1c_b.jpg",
      "name": "명화당 (명동1호점)",
      "address": "명동",
      "phoneNumber": '010-4479-1429',
      "score": 4.2,
      "gScore": 4.2,
      "nScore": 4.7,
      "kScore": 4.0,
      "longitude": 126.983851,
      "latitude": 37.562408,
    },
    {
      "image": "https://live.staticflickr.com/506/19718391335_b9bc4dfda5_b.jpg",
      "name": "딸깍발이",
      "address": "경복궁 돌담길",
      "phoneNumber": '010-4479-1429',
      "score": 4.0,
      "gScore": 4.2,
      "nScore": 4.7,
      "kScore": 4.0,
      "longitude": 126.997057,
      "latitude": 37.560958,
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmLWXVKAY-Wv1OMHor0tRoIMWut9elpYsnIGGWvp_8xzvfL1YnmzGGCFOAB2iXr6H2i8A&usqp=CAU",
      "name": "남산 떡볶이",
      "address": "남산",
      "phoneNumber": '010-4479-1429',
      "score": 3.5,
      "gScore": 4.2,
      "nScore": 4.7,
      "kScore": 4.0,
      "longitude": 126.976165,
      "latitude": 37.55302,
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi9ouD547u9_-2vb5jtW9Zzg5ana1lfgSIw8HTW7UytuvB_eMDbMI9-LSHB2Ap-YECxEI&usqp=CAU",
      "name": "꽃사슴떡볶이",
      "address": "강남",
      "phoneNumber": '010-4479-1429',
      "score": 3.0,
      "gScore": 4.2,
      "nScore": 4.7,
      "kScore": 4.0,
      "longitude": 127.002738,
      "latitude": 37.559074,
    },
    {
      "image":
          "https://live.staticflickr.com/7525/16131188069_fe15196469_b.jpg",
      "name": "루비떡볶이",
      "address": "강남",
      "phoneNumber": '010-4479-1429',
      "score": 3.1,
      "gScore": 4.2,
      "nScore": 4.7,
      "kScore": 4.0,
      "longitude": 127.037666,
      "latitude": 37.524634,
    }
  ]
};
CardList? cardList;

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key, required this.long, required this.lati});
  final double? long;
  final double? lati;

  @override
  _GridViewPage createState() => _GridViewPage();
}

class _GridViewPage extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    List<String> addressPlace = ['명동', '경복궁돌담길', '강남'];
    final String address = addressPlace[0];
    cardList = CardList.fromJson(cardItem);
    return Scaffold(
      drawer: drawerKangru(),
      appBar: AppBarKangru(
        address: address,
        appBar: AppBar(),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: cardList!.list!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //한행당 몇개의 item
              childAspectRatio: 1 / 1.4, //가로세로 비율
              mainAxisSpacing: 10, // 수평패딩
              crossAxisSpacing: 10), // 수직패딩
          itemBuilder: (BuildContext context, int index) {
            final double meter = Geolocator.distanceBetween(
                widget.lati!,
                widget.long!,
                cardList!.list!.elementAt(index).latitude!,
                cardList!.list!.elementAt(index).longitude!);
            return CardKangru(
                imageUrl: cardList!.list!.elementAt(index).image!,
                businessName:
                    '${index + 1}.${cardList!.list!.elementAt(index).name!}',
                score: cardList!.list!.elementAt(index).score!,
                distance: '${(meter * 0.001).toStringAsFixed(2)} Km');
          }),
    );
  }
}
