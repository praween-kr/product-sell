import 'dart:developer';

import 'package:flutter/material.dart';

class SwapperWidget extends StatefulWidget {
  const SwapperWidget({super.key});

  @override
  State<SwapperWidget> createState() => _SwapperWidgetState();
}

class _SwapperWidgetState extends State<SwapperWidget> {
  List<Widget> list = <Widget>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list.add(drag("1"));
    list.add(drag("2"));
    list.add(drag("3"));
    list.add(drag("4"));
    list.add(drag("5"));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: list,
      ),
    );
  }

  Draggable<int> drag(String text) {
    return Draggable<int>(
      // Data is the value this Draggable stores.
      onDragEnd: (DraggableDetails details) {
        // log("dfdsf $details");

        setState(() {
          list.removeAt(0);
          log("dsfs:::: ${list.length}");
        });
      },
      data: 10,
      feedback: Container(
        color: Colors.deepOrange,
        height: 100,
        width: 100,
        child: const Icon(Icons.directions_run),
      ),
      childWhenDragging: SizedBox(
        height: 120.0,
        width: 120.0,
        child: Center(
          child: Image.asset('assets/images/tomato_greyed.png'),
        ),
      ),
      // childWhenDragging: Container(
      //   height: 100.0,
      //   width: 100.0,
      //   color: Colors.pinkAccent,
      //   child: const Center(
      //     child: Text('Child When Dragging'),
      //   ),
      // ),
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.lightGreenAccent,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
