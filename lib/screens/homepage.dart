import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<String> bannerImages = [
    'assets/banner.png',
    'assets/anime.jpg',
    'assets/naruto.jpg',
    'assets/demon.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-slide every 3 seconds
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Sliding Banner
              Container(
                height: 200, // Set height
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: bannerImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/preview'),
                          child: Image.asset(
                            bannerImages[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          bannerImages.length,
                              (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              _buildCategoryIcons(),
              SizedBox(height: 15),
              _buildRecommendedComics(),
            ],
          ),
        ),
      ),
    );
  }

  // Category Icons
  Widget _buildCategoryIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildIconButton('assets/Taps.png', 'WIN-WIN'),
            SizedBox(width: 42),
            _buildIconButton('assets/Taps(1).png', 'VOTE'),
            SizedBox(width: 42),
            _buildIconButton('assets/Taps(2).png', 'RANKING'),
            SizedBox(width: 42),
            _buildIconButton('assets/Taps(3).png', 'GENRES'),
          ],
        ),
      ),
    );
  }

  // Recommended Comics
  Widget _buildRecommendedComics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Recommended For You ✨',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                onTap: () => {Navigator.pushNamed(context, '/preview')},
                child: _buildBookItem(
                    'Solo Leveling', 'Action/Adventure', 'assets/solo.jpg')),
            _buildBookItem('The Adventures of Chahal Pahal', 'Alpha Comics',
                'assets/thumbnail(1).png'),
            _buildBookItem(
                'Demon Slayer', 'Sci-fi/Action', 'assets/demon.jpg'),
            _buildBookItem(
                'Your Name', 'Romance', 'assets/anime.jpg'),
            _buildBookItem(
                'Naruto', 'Comics', 'assets/naruto.jpg'),
            _buildBookItem(
                'Rakshas Raja', 'Raj Comics', 'assets/thumbnail(5).png'),
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
              onPressed: () => {},
              child: Text(
                'Roll Again',
                style: TextStyle(color: Color(0xFFA3D749), fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Category Button
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

  // Book Card
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
