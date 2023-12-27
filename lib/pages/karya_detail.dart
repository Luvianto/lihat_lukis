import 'package:flutter/material.dart';
import 'package:lihat_lukis/models/karya.dart';

class KaryaDetail extends StatelessWidget {
  const KaryaDetail({Key? key, required this.karya}) : super(key: key);
  final Karya karya;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                karya.imageAsset,
                width: double.infinity,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          //
          const MyDivider(textBetween: 'Title & Artist'),
          //
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
          //
          const SizedBox(height: 25.0),
          //
          //
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Text(
                  karya.artist,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  karya.yearMade,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          //
          const SizedBox(height: 25.0),
          //
          const MyDivider(textBetween: 'Description'),
          //
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
    );
  }
}

class MyDivider extends StatelessWidget {
  final String textBetween;
  const MyDivider({super.key, required this.textBetween});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              textBetween,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
