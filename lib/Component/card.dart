import 'package:flutter/material.dart';

class CardKangru extends StatelessWidget {
  const CardKangru({
    super.key,
    required this.imageUrl,
    required this.businessName,
    required this.score,
    required this.distance,
  });

  final String imageUrl;
  final String businessName;
  final double score;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(0.0),
        minWidth: 0.0,
        onPressed: () {
          null;
          //TODO next page
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imageUrl,
                height: ((MediaQuery.of(context).size.width) - 42) /
                    2, //app화면 가로 - Padding /2
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              businessName,
            ),
            Text(
              score.toString(),
            ),
            Text(
              distance,
            )
          ],
        ),
      ),
    );
  }
}
