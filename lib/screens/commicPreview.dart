import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'parshuram1.dart'; // ✅ Import ParshuramEpisodePage

class ComicPreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: SafeArea(child: ComicContent()),
    );
  }
}

class ComicContent extends StatefulWidget {
  @override
  _ComicContentState createState() => _ComicContentState();
}

class _ComicContentState extends State<ComicContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? bannerImage;
  String? previewImage;
  String? parshuramImage;
  List<String> episodes = ['Episode 1', 'Episode 2', 'Episode 3'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchEpisodes();
  }

  Future<void> fetchImages() async {
    try {
      DocumentSnapshot previewSnapshot = await FirebaseFirestore.instance
          .collection('preview')
          .doc('parshuram')
          .get();

      DocumentSnapshot comicsSnapshot = await FirebaseFirestore.instance
          .collection('comics')
          .doc('images')
          .get();

      if (previewSnapshot.exists && comicsSnapshot.exists) {
        setState(() {
          bannerImage = previewSnapshot['parshuram'];
          previewImage = previewSnapshot['preview'];
          parshuramImage = comicsSnapshot['parshuram'];
        });
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> fetchEpisodes() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('comics')
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          episodes.addAll(snapshot.docs.map((doc) => doc.id).toList());
        });
      }
    } catch (e) {
      print('Error fetching episodes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchImages(),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 250),
                    child: bannerImage != null
                        ? CachedNetworkImage(
                      imageUrl: bannerImage!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(color: Color(0xFFA3D749)),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    )
                        : Container(height: 200, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 20),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_back_ios_sharp,
                              size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Parshuram: Blood and Dharma', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('VrindKavi', style: TextStyle(color: Colors.white70, fontSize: 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(6),
                              child: Text('Action', style: TextStyle(color: Colors.white, fontSize: 13),),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(6),
                              child: Text('Indian Mythology', style: TextStyle(color: Colors.white, fontSize: 13),),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(6),
                              child: Text('🎉New', style: TextStyle(color: Color(0xFF22D575), fontSize: 13),),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    )
                  )
                ],
              ),
              TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white54,
                indicatorColor: Colors.lightGreenAccent,
                labelStyle:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                tabs: [
                  Tab(text: 'Preview',),
                  Tab(text: 'Episodes'),
                ],
              ),
              Container(
                height: 500,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPreviewTab(),
                    _buildEpisodesTab(context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: previewImage != null
                ? CachedNetworkImage(
              imageUrl: previewImage!,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
                : Container(height: 300, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodesTab(BuildContext context) {
    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        bool isComingSoon = index == 1 || index == 2;

        return GestureDetector(
          onTap: () {
          if (!isComingSoon) {
            Navigator.pushNamed(context, '/parshuram');
      }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                parshuramImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          width: 80,
                          height: 80,
                                        imageUrl: parshuramImage!,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                          CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: Colors.red),
                                    ),
                    )
                    : Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[800],
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    episodes[index],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                isComingSoon
                    ? Text(
                  'Coming Soon',
                  style: TextStyle(color: Color(0xFFA3D749), fontSize: 14),
                )
                    : Icon(Icons.play_circle_fill, color: Colors.white70),
              ],
            ),
          ),
        );

      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
