import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  final List<String> downloads = []; // Add downloaded items here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      appBar: AppBar(
        backgroundColor:  Color(0xFFA3D749),
        title: Text('Downloads', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: downloads.isEmpty
          ? Center(
        child: Text(
          'No Downloads',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: downloads.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(downloads[index], style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.book, color: Colors.white),
          );
        },
      ),
    );
  }
}
