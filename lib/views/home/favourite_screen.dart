import 'package:flutter/material.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Center(
              child: AppText(
                text: "My Favourite",
                textSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
