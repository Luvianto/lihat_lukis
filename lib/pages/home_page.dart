// import material.dart
import 'package:flutter/material.dart';

// import library staggered view
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//components
import 'package:lihat_lukis/components/my_drawer.dart';
import 'package:lihat_lukis/components/my_tile.dart';
import 'package:lihat_lukis/data/karya_data.dart';
import 'package:lihat_lukis/models/karya.dart';
import 'package:lihat_lukis/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lihat_lukis/pages/search_page.dart';

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
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: goToSearchPage,
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
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
          if (index < karyaList.length) {
            Karya karya = karyaList[index];
            return MyTile(
              varKarya: karya,
            );
          }
        }),
      ),
    );
  }
}
