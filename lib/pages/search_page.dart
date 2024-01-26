import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      // menghilangkan no result
      isShowUser = true;

      // ubah list yang ditampilkan
      displayList = karyaList
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a user',
            labelStyle: TextStyle(color: Colors.white),
          ),
          onFieldSubmitted: updateList,
        ),
      ),
      body: isShowUser
          ? Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Users')
                        .where('username',
                            isGreaterThanOrEqualTo:
                                searchController.text.toLowerCase())
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                child: const Icon(Icons.person),
                              ),
                              title: Text(
                                snapshot.data!.docs[index]['username'],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('error: ${snapshot.error}'),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Expanded(
                    child: GridView.custom(
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
                  childrenDelegate:
                      SliverChildBuilderDelegate((context, index) {
                    if (index < displayList.length) {
                      return MyTile(
                        varKarya: displayList[index],
                      );
                    }
                  }),
                ))
              ],
            )
          : Center(
              child: Text(
                'No results',
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
    );
  }
}
