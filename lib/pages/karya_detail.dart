import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lihat_lukis/components/my_divider.dart';
import 'package:lihat_lukis/components/my_like_button.dart';
import 'package:lihat_lukis/models/karya.dart';

class KaryaDetail extends StatefulWidget {
  const KaryaDetail({Key? key, required this.karya}) : super(key: key);
  final Karya karya;

  @override
  State<KaryaDetail> createState() => _KaryaDetailState();
}

class _KaryaDetailState extends State<KaryaDetail> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // if the user email is in the list of likes from karya
  @override
  void initState() {
    super.initState();
    isLiked = widget.karya.likes.contains(currentUser.email);
  }

  // toggle like or dislike
  void toggleLike() {
    setState(() {
      // Toggle the liked status by calling the method on the model
      widget.karya.toggleLike(currentUser.email);
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                widget.karya.imageAsset,
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
              widget.karya.title,
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
                  widget.karya.artist,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  widget.karya.yearMade,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          MyLikeButton(
            isLiked: isLiked,
            onTap: toggleLike,
          ),
          //
          const SizedBox(height: 25.0),
          //
          const MyDivider(textBetween: 'Description'),
          //
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.karya.description,
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
