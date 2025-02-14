import 'package:flutter/material.dart';

class RewardPage extends StatelessWidget {
  final int userPoints = 150; // Example: User has 150 points

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
        backgroundColor: Color(0xFFA3D749),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView( // Make the page scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPointsCard(),
              SizedBox(height: 20),
              _buildSectionTitle('Available Offers'),
              _buildOfferList(),
              SizedBox(height: 20),
              _buildSectionTitle('Redeemable Rewards'),
              _buildRewardList(),
            ],
          ),
        ),
      ),
    );
  }

  // Display user's earned points
  Widget _buildPointsCard() {
    return Card(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Points',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  '$userPoints',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(Icons.stars, color: Colors.yellowAccent, size: 40),
          ],
        ),
      ),
    );
  }

  // Section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // List of available offers
  Widget _buildOfferList() {
    return Column(
      children: [
        _buildOfferItem('🎉 Get 10% off on next purchase!'),
        _buildOfferItem('🚀 Free access to premium comics for 1 week!'),
        _buildOfferItem('🎁 Refer a friend & get 50 bonus points!'),
      ],
    );
  }

  Widget _buildOfferItem(String offer) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        leading: Icon(Icons.local_offer, color: Colors.orangeAccent),
        title: Text(offer, style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  // List of redeemable rewards
  Widget _buildRewardList() {
    return Column(
      children: [
        _buildRewardItem('📚 Unlock Exclusive Story', 100),
        _buildRewardItem('💎 500 Bonus Points', 200),
        _buildRewardItem('🔥 VIP Badge on Profile', 300),
      ],
    );
  }

  Widget _buildRewardItem(String reward, int requiredPoints) {
    bool canRedeem = userPoints >= requiredPoints;
    return Card(
      color: canRedeem ? Colors.green[700] : Colors.grey[850],
      child: ListTile(
        leading: Icon(Icons.card_giftcard, color: Colors.white),
        title: Text(reward, style: TextStyle(color: Colors.white)),
        subtitle: Text('Requires $requiredPoints Points', style: TextStyle(color: Colors.white70)),
        trailing: ElevatedButton(
          onPressed: canRedeem ? () {} : null,
          child: Text('Redeem'),
          style: ElevatedButton.styleFrom(
            backgroundColor: canRedeem ? Colors.orange : Colors.grey,
          ),
        ),
      ),
    );
  }
}
