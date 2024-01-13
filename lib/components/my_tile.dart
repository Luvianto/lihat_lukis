import 'package:flutter/material.dart';
import 'package:lihat_lukis/models/karya.dart';
import 'package:lihat_lukis/pages/karya_detail.dart';

class MyTile extends StatelessWidget {
  final Karya varKarya;
  const MyTile({super.key, required this.varKarya});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return KaryaDetail(karya: varKarya);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: Image.asset(
          varKarya.imageAsset,
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
