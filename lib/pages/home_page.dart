import 'package:flutter/material.dart';

// import library staggered view
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//components
import 'package:lihat_lukis/components/my_drawer.dart';
import 'package:lihat_lukis/components/my_tile.dart';

import 'package:lihat_lukis/data/karya_data.dart';
import 'package:lihat_lukis/pages/favourite_page.dart';
import 'package:lihat_lukis/pages/profile_page.dart';
import 'package:lihat_lukis/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  //navigate to profile page
  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
  }

  //navigate to profile page
  void goToFavouritePage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FavouritePage(),
        ));
  }

  //navigate to profile page
  void goToSearchPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'L I H A T L U K I S',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: goToSearchPage,
          ),
        ],
      ),
      drawer: MyDrawer(
        onLikeTap: goToFavouritePage,
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      body: karyaList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada karya!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          : GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  const QuiltedGridTile(2, 2),
                  const QuiltedGridTile(2, 1),
                  const QuiltedGridTile(2, 1),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  return MyTile(
                    varKarya: karyaList[index],
                  );
                },
                childCount: karyaList.length,
              ),
            ),
    );
  }
}
