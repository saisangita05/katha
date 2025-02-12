import 'package:flutter/material.dart';

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
  bool isSubscribed = false;  // Subscription status flag

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 200),
                child: Image.asset('assets/banner.png',
                    width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_back_ios_sharp,
                              size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Colors.black.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isSubscribed = true;
                        });
                      },
                      child: Text(
                        isSubscribed ? 'Subscribed' : 'Subscribe',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildTag('Action'),
                    _buildTag('Indian Mythology'),
                    _buildTag('🎉NEW', isNew: true),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Vikram Vetal',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('VrindKavi', style: TextStyle(color: Colors.white70)),
                    Text('Read More',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),

          // Tabs for Preview and Episodes
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.lightGreenAccent,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 20),
            tabs: [
              Tab(text: 'Preview'),
              Tab(text: 'Episodes' ),
            ],
          ),

          Container(
            height: 500,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPreviewTab(),
                isSubscribed ? _buildEpisodesTab() : _buildLockedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag, {bool isNew = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        tag,
        style: TextStyle(color: !isNew ? Colors.white : Colors.green, fontSize: 15),
      ),
    );
  }

  Widget _buildPreviewTab() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Show Ad Here',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 20),
        Image.asset(
            'assets/preview.png',
            width: double.infinity,
          fit: BoxFit.fill,
        )
      ],
    );
  }

  // Episodes Tab (Visible after subscribing)
  Widget _buildEpisodesTab() {
    final episodes = [
      {'title': 'Episode 3', 'image': 'assets/panel1.png'},
      {'title': 'Episode 2', 'image': 'assets/panel2.png'},
      {'title': 'Episode 1', 'image': 'assets/panel3.png'},
      {'title': 'Preview', 'image': 'assets/panel1.png'},
    ];

    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Show Ad Here',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/thumbnail.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        episodes[index]['title']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Read for free\nwith ads',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  // Locked Tab (Visible when not subscribed)
  Widget _buildLockedTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Colors.white54, size: 50),
          SizedBox(height: 10),
          Text(
            'Subscribe to view Episodes!',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
