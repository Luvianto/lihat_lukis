import 'package:flutter/material.dart';
import 'package:lihat_lukis/data/karya_data.dart';
import 'package:lihat_lukis/models/karya.dart';
import 'package:lihat_lukis/pages/karya_detail.dart';

class KaryaPage extends StatelessWidget {
  const KaryaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Karya karya = karyaList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return KaryaDetail(karya: karya);
            }));
          },
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      karya.imageAsset,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(karya.title),
                        Text(karya.artist),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: karyaList.length,
    );
  }
}
