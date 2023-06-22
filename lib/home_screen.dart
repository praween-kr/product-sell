import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Hello! jenny"),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.amberAccent,
              ),
              Text("Street albert, california"),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(Icons.filter_alt_rounded, color: Colors.yellow),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(Icons.filter_alt_rounded, color: Colors.yellow),
              ),
            ],
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search"),
            ),
          ),
        ],
      ),
    );
  }
}
