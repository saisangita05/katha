import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String heroImage = "";
  Map<String, String> recommendedComics = {};

  @override
  void initState() {
    super.initState();
    _fetchImagesFromFirestore();
  }

  Future<void> _fetchImagesFromFirestore() async {
    FirebaseFirestore.instance.collection('comics').doc('images').get().then((doc) {
      if (doc.exists) {
        setState(() {
          heroImage = doc.data()!["heroimage"] ?? "";
          recommendedComics = Map<String, String>.from(doc.data()!);
          recommendedComics.remove("heroimage"); // Remove hero image from recommendations
        });
      }
    }).catchError((error) {
      print("Error fetching images: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroImage(),
              SizedBox(height: 20),
              _buildRecommendedComics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return heroImage.isNotEmpty
        ? GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/preview'),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(heroImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 60), // Moves text slightly lower
              Text(
                "Parshuram: Blood and Dharma",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/preview'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA3D749),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text("Read Now", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),)
              )
            ],
          ),
        ),
      ),
    )
        : Center(child: CircularProgressIndicator(color: Color(0xFFA3D749),));
  }

  Widget _buildRecommendedComics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'For You ✨',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: recommendedComics.containsKey("parshuram")
              ? GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/preview'),
            child: Column(
              children: [
                _buildBookItem(recommendedComics["parshuram"] ?? "", title: ""),
                SizedBox(height: 3),
                Text(
                  "Parshuram",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Vrindkavi",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          )
              : Center(child: CircularProgressIndicator(color: Color(0xFFA3D749))),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Coming Soon 🥳',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        _buildComingSoonGrid(),
      ],
    );
  }

  Widget _buildComingSoonGrid() {
    List<MapEntry<String, String>> comingSoonComics = recommendedComics.entries
        .where((entry) => entry.key != 'parshuram')
        .toList();

    comingSoonComics.sort((a, b) {
      if (a.key == "solo_leveling") return -1;
      if (b.key == "solo_leveling") return 1;
      if (a.key == "eleceed" && b.key == "omniscient_reader") return -1;
      if (b.key == "eleceed" && a.key == "omniscient_reader") return 1;
      return 0;
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (comingSoonComics.isNotEmpty)
            _buildBookItem(comingSoonComics[1].value, title: "Solo Leveling", isHero: true),
          SizedBox(height: 10,),
          if (comingSoonComics.length > 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBookItem(comingSoonComics[0].value, title: "Eleceed", isSquare: true),
                SizedBox(width: 8), // Added space between Eleceed and Omniscient Reader
                _buildBookItem(comingSoonComics[2].value, title: "Omniscient Reader", isSquare: true),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBookItem(String imageUrl, {String title = "", bool isHero = false, bool isSquare = false}) {
    return Container(
      width: isHero ? double.infinity : (isSquare ? 150 : 120),
      height: isHero ? 150 : (isSquare ? 100 : 120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,)
          ],
        ),
    );
  }
}