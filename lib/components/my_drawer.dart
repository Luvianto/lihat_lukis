import 'package:flutter/material.dart';
import 'package:lihat_lukis/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLikeTap;
  final void Function()? onSignOut;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              // Home list tile
              MyListTile(
                icon: Icons.home,
                text: 'B E R A N D A',
                onTap: () => Navigator.pop(context),
              ),

              //Profile list tile
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L',
                onTap: onProfileTap,
              ),

              //Likes list tile
              MyListTile(
                icon: Icons.favorite_outline,
                text: 'F A V O R I T',
                onTap: onLikeTap,
              ),
            ],
          ),

          //Logout list tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'K E L U A R',
              onTap: onSignOut,
            ),
          )
        ],
      ),
    );
  }
}
