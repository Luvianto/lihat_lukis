import 'package:flutter/material.dart';
import 'package:lihat_lukis/models/karya.dart';

class KaryaDetail extends StatelessWidget {
  const KaryaDetail({Key? key, required this.karya}) : super(key: key);
  final Karya karya;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                karya.imageAsset,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  karya.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(height: 8.0),
                        Text(karya.artist),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.lock_clock_rounded),
                        const SizedBox(height: 8.0),
                        Text(karya.yearMade),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  karya.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
