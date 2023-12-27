import 'package:flutter/material.dart';
import 'package:lihat_lukis/data/karya_data.dart';
import 'package:lihat_lukis/models/karya.dart';
import 'package:lihat_lukis/pages/karya_detail.dart';

class KaryaPage extends StatelessWidget {
  const KaryaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: karyaList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        final Karya karya = karyaList[index];
        return Container(
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(color: Colors.blue.shade50),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return KaryaDetail(karya: karya);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                karya.imageAsset,
                height: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
      },
    );
  }
}
