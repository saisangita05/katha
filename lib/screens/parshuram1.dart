import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ParshuramEpisodePage extends StatefulWidget {
  @override
  _ParshuramEpisodePageState createState() => _ParshuramEpisodePageState();
}

class _ParshuramEpisodePageState extends State<ParshuramEpisodePage> {
  List<String> episodeImages = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEpisodeImages();
  }

  Future<void> fetchEpisodeImages() async {
    try {
      DocumentSnapshot episodeSnapshot = await FirebaseFirestore.instance
          .collection('episodes')
          .doc('parshuram')
          .get();

      if (episodeSnapshot.exists) {
        List<String> images = [];

        if (episodeSnapshot.data() != null) {
          var data = episodeSnapshot.data() as Map<String, dynamic>;

          if (data.containsKey('episode 1')) images.add(data['episode 1']);
          if (data.containsKey('episode 1 con')) images.add(data['episode 1 con']);
          if (data.containsKey('episode 1 cont')) images.add(data['episode 1 cont']);
          if (data.containsKey('parshuram4')) images.add(data['parshuram4']);
          if (data.containsKey('parshuram5')) images.add(data['parshuram5']);


        }

        if (mounted) {
          setState(() {
            episodeImages = images;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'No episode images found.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching episode images: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
          : ListView.builder(
        padding: EdgeInsets.zero, // ✅ No extra space
        itemCount: episodeImages.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: episodeImages[index],
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: Colors.red),
            fit: BoxFit.cover, // ✅ Image covers full width
            width: MediaQuery.of(context).size.width,
          );
        },
      ),
    );
  }
}
