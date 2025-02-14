import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; // To store the selected profile image
  final picker = ImagePicker();
  final String userName = "Sai Sangita Adhek"; // Example user name

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFA3D749),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image with Clickable Option to Change
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) as ImageProvider
                          : AssetImage("assets/sai.jpg"), // Default Image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black87,
                        radius: 18,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // User Name
              Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Wishlist Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wishlist Comics',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Wishlist List
              _buildWishlist(),
            ],
          ),
        ),
      ),
    );
  }

  // Wishlist Comic Item
  Widget _buildWishlist() {
    List<String> wishlistComics = [
      "One Piece",
      "Naruto",
      "Demon Slayer",
      "Attack on Titan",
      "Death Note",
      "Dragon Ball",
    ]; // Example wishlist

    return wishlistComics.isNotEmpty
        ? Column(
      children: wishlistComics.map((comic) => _buildWishlistItem(comic)).toList(),
    )
        : Center(
      child: Text(
        "Your wishlist is empty!",
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }

  Widget _buildWishlistItem(String comic) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        leading: Icon(Icons.bookmark, color: Colors.blueGrey),
        title: Text(comic, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
