import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lihat_lukis/components/my_tile.dart';
import 'package:lihat_lukis/data/karya_data.dart';
import 'package:lihat_lukis/models/karya.dart';

// import library staggered view
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  List<Karya> displayList = [];

  // update list setiap kali user menekan tombol search pada search bar
  void updateList(String value) {
    setState(() {
      if (searchController.text.isNotEmpty) {
        // menghilangkan pesan "Kosong?!?"
        isShowUser = true;

        // ubah list yang ditampilkan
        displayList = karyaList
            .where((element) =>
                element.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        isShowUser = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TextFormField(
          style: const TextStyle(
            color: Colors.white,
          ),
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Cari user atau karya..',
            labelStyle: TextStyle(color: Colors.white),
          ),
          onFieldSubmitted: updateList,
        ),
      ),
      body: isShowUser
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Pengguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Users')
                        .where('username',
                            isGreaterThanOrEqualTo:
                                searchController.text.toLowerCase())
                        .orderBy('username')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Terjadi sebuah kesalahan!'),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('Pengguna tidak ditemukan!',
                              style: TextStyle(color: Colors.white)),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final user = snapshot.data!.docs[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                child: const Icon(Icons.person),
                              ),
                              title: Text(
                                user['username'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Karya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                    child: GridView.custom(
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 4,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
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
                        varKarya: displayList[index],
                      );
                    },
                    childCount: displayList.length,
                  ),
                ))
              ],
            )
          : Center(
              child: Text(
                'Kosong?!?',
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
    );
  }
}
