import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lihat_lukis/components/my_tile.dart';
import 'package:lihat_lukis/data/karya_data.dart';

// import library staggered view
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final displayLikes = karyaList
      .where((element) =>
          element.likes.contains(FirebaseAuth.instance.currentUser?.email))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'L I K E S',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GridView.custom(
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
          if (index < displayLikes.length) {
            return MyTile(
              varKarya: displayLikes[index],
            );
          }
        }),
      ),
    );
  }
}
