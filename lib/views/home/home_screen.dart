import 'package:flutter/material.dart';

import '../../utills/common_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AppText(
              text: "  Hello, jenny",
              textSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.amberAccent,
                ),
                const AppText(
                  text: "Street albert, california",
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.filter_alt_rounded,
                      color: Colors.yellow),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
            // AppTextField(
            //   height: 45,
            //   title: "Search",
            //   borderRadius: BorderRadius.circular(50),
            //   prefix: Icon(Icons.search),
            //   containerColor: Color(0xffF7F7F7),
            // ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Shop by category",
                  fontWeight: FontWeight.w600,
                  textSize: 16,
                  color: Colors.black,
                ),
                AppText(
                    text: "See all",
                    fontWeight: FontWeight.w600,
                    textSize: 12,
                    color: Color(0x80000000)),
              ],
            ),
            Expanded(
              child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 25,
                      childAspectRatio: 0.68),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    //var data = categoryList[index];
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 30, left: 30, right: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Icon(Icons.message)),
                          const SizedBox(
                            height: 5,
                          ),
                          const AppText(text: "Men")
                        ],
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.yellow,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
