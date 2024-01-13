import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lihat_lukis/data/karya_data.dart';
import 'package:lihat_lukis/models/karya.dart';
import 'package:lihat_lukis/pages/karya_detail.dart';

class KaryaPage extends StatelessWidget {
  const KaryaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(2, 1),
          QuiltedGridTile(2, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate((context, index) {
        if (index < karyaList.length) {
          Karya karya = karyaList[index];
          return Tile(
            varKarya: karya,
          );
        }
      }),
    );
  }
}

class Tile extends StatelessWidget {
  final Karya varKarya;
  const Tile({super.key, required this.varKarya});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return KaryaDetail(karya: varKarya);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.asset(
          varKarya.imageAsset,
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
