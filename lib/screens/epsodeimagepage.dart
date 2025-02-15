import 'package:flutter/material.dart';

class EpisodeImagePage extends StatelessWidget {
  final String imageUrl;

  EpisodeImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Episode 2"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
