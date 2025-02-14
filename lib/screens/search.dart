import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _allComics = [
    "One Piece",
    "Naruto",
    "Demon Slayer",
    "Attack on Titan",
    "Death Note",
    "Dragon Ball",
    "Jujutsu Kaisen",
    "My Hero Academia",
  ]; // Example comic list

  List<String> _filteredComics = [];

  @override
  void initState() {
    super.initState();
    _filteredComics = _allComics; // Initially show all comics
  }

  void _searchComics(String query) {
    setState(() {
      _filteredComics = _allComics
          .where((comic) =>
          comic.toLowerCase().contains(query.toLowerCase())) // Case insensitive search
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Comics'),
        backgroundColor: Color(0xFFA3D749),
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchComics,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search for comics...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _filteredComics.isNotEmpty
                  ? ListView.builder(
                itemCount: _filteredComics.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[850],
                    child: ListTile(
                      leading: Icon(Icons.book, color: Colors.blueGrey),
                      title: Text(
                        _filteredComics[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  "No comics found!",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
