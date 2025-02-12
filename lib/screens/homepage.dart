import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, '/preview'),
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 200, // Maximum height in pixels
                  ),
                  child: Image.asset('assets/banner.png', width: double.infinity, fit: BoxFit.cover,),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34.0),
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildIconButton('assets/Taps.png', 'WIN-WIN'),
                            SizedBox(width: 42), // Add spacing between icons
                            _buildIconButton('assets/Taps(1).png', 'VOTE'),
                            SizedBox(width: 42),
                            _buildIconButton('assets/Taps(2).png', 'RANKING'),
                            SizedBox(width: 42),
                            _buildIconButton('assets/Taps(3).png', 'GENRES'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Recommended For You ✨',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/preview')
                        },
                          child: _buildBookItem('Vikraam Vetal', 'VrindKavi', 'assets/thumbnail.png')
                      ),
                      _buildBookItem('The Adventures of Chahal Pahal', 'Alpha Comics', 'assets/thumbnail(1).png'),
                      _buildBookItem('Parshuram', 'VrindKavi', 'assets/thumbnail(2).png'),
                      _buildBookItem('Ramayana', 'VrindKavi', 'assets/thumbnail(3).png'),
                      _buildBookItem('Mahabharata', 'Raj Comics', 'assets/thumbnail(4).png'),
                      _buildBookItem('Rakshas Raja', 'Raj Comics', 'assets/thumbnail(5).png'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1F3100),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: ()=>{
                        }, // Removed functionality
                        child: Text(
                          'Roll Again',
                          style:
                          TextStyle(color: Color(0xFFA3D749), fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(String imagePath, String label) {
    return Column(
      children: [
        Image.asset(imagePath, width: 40, height: 40),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBookItem(String title, String author, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Text(
          author,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
