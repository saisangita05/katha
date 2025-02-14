import 'package:flutter/material.dart';
import 'package:katha/screens/homepage.dart';
import 'package:katha/screens/library.dart';
import 'package:katha/screens/reward.dart';
import 'package:katha/screens/search.dart';
import 'package:katha/screens/profile.dart';// Import RewardPage

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          LibraryPage(),
          RewardPage(),
          SearchPage(),
          ProfilePage(),// ✅ Navigates to RewardPage when clicked
          //Center(child: Text('Search Page', style: TextStyle(color: Colors.white))),
         // Center(child: Text('Profile Page', style: TextStyle(color: Colors.white))),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(color: Colors.grey.shade800, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.book_outlined, 'Library', 1),
            _buildNavItem(Icons.card_giftcard, 'Rewards', 2), // ✅ Navigates to RewardPage
            _buildNavItem(Icons.search, 'Search', 3),
            _buildNavItem(Icons.circle, 'Profile', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.lightGreenAccent : Colors.white70,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.lightGreenAccent : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
