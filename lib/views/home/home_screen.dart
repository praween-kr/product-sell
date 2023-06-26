import 'package:flutter/material.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AppText(
                text: "Hello, jenny",
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
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.filter_alt_rounded,
                        color: Colors.white),
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
              AppTextField(
                height: 45,
                title: "Search",
                style: TextStyle(color: Color(0x80000000)),
                borderRadius: BorderRadius.circular(50),
                prefix: const Icon(Icons.search),
                containerColor: const Color(0xffF7F7F7),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Row(
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
              ),
              Expanded(
                child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 2,
                            childAspectRatio: 0.9),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: const Icon(Icons.message)),
                            const SizedBox(
                              height: 5,
                            ),
                            const AppText(text: "Men")
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Align(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
