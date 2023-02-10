import 'package:flutter/material.dart';
import '../data/data.dart';
import '../Component/appbar.dart';
import '../Component/card.dart';
import '../data/cardItem.dart';

final cardItem = {
  "list": [
    {
      "image":
          "https://img.siksinhot.com/place/1621306337133097.jpeg?w=540&h=436&c=Y",
      "name": "신세계 떡볶이",
      "score": 4.5,
    },
    {
      "image":
          "https://live.staticflickr.com/7364/12693021913_468f3bbc1c_b.jpg",
      "name": "신세계 떡볶이",
      "score": 4.2,
    },
    {
      "image": "https://live.staticflickr.com/506/19718391335_b9bc4dfda5_b.jpg",
      "name": "신세계 떡볶이",
      "score": 4.0,
    },
    {
      "image":
          "https://img.siksinhot.com/place/1621306337133097.jpeg?w=540&h=436&c=Y",
      "name": "신세계 떡볶이",
      "score": 3.5,
    },
    {
      "image":
          "https://img.siksinhot.com/place/1621306337133097.jpeg?w=540&h=436&c=Y",
      "name": "신세계 떡볶이",
      "score": 3.0,
    },
    {
      "image":
          "https://img.siksinhot.com/place/1621306337133097.jpeg?w=540&h=436&c=Y",
      "name": "신세계 떡볶이",
      "score": 3.1,
    }
  ]
};
CardList? cardList;
KangruData kangruData = KangruData();

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
    final String address = kangruData.address[0];
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
            return CardKangru(
                imageUrl: cardList!.list!.elementAt(index).image!,
                businessName:
                    '${index + 1}.${cardList!.list!.elementAt(index).name!}',
                score: cardList!.list!.elementAt(index).score!);
          }),
    );
  }
}
