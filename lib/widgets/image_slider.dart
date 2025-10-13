import 'dart:async';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> images = [
    'https://uykamera653-jpg.github.io/Bingoo/images/file_00000000871061f9ab5abcf210b3d93b.png',
    'https://uykamera653-jpg.github.io/Bingoo/images/file_00000000c8bc622fbaeb46440338498e.png',
    'https://uykamera653-jpg.github.io/Bingoo/images/file_000000009b5061f6a4aa1a5ae97559f2.png',
  ];

  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(images[currentIndex], fit: BoxFit.cover),
      ),
    );
  }
}
