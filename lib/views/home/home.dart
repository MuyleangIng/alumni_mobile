import 'package:Alumni/views/home/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cardsData = [
      {
        'name': 'MuyleangIng',
        'status': 'Status message or description here',
        'image': 'assets/images/2.jpg',
      },
      {
        'name': 'John Doe',
        'status': 'Another status message here',
        'image': 'assets/images/rith.jpg',
      },
      {
        'name': 'Jane Smith',
        'status': 'Yet another status message here',
        'image': 'assets/images/2.jpg',
      },
      {
        'name': 'Alex Johnson',
        'status': 'This is a different status message',
        'image': 'assets/images/1.jpg',
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Alumni')
                Image.asset(
                  'assets/images/alumni-text.jpg', // Path to your local image
                  height: 30, // Adjust the height to fit your design
                ),
              ],
            ),
            Spacer(),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                  style: TextStyle(color: Colors.black),
                  onSubmitted: (query) {
                    // Add your search logic here
                    print('Search query: $query');
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_active),
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/1.jpg'),
                radius: 25, // Set the radius to adjust the size of the CircleAvatar
              ),
            )
          ],
        ),
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 330,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Flexible space bar'),
              background: Image.asset(
                'assets/images/1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final card = cardsData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/icon/app_icon.png'),
                              radius: 25,
                            ),
                            title: Text(card['name']!),
                            subtitle: Text(card['status']!),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'This is a detailed description that can span multiple lines and gives more information about the status.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Image.asset(card['image']!),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  // Add your like action here
                                },
                                icon: Icon(Icons.thumb_up),
                                label: Text('Like'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  // Add your comment action here
                                },
                                icon: Icon(Icons.comment),
                                label: Text('Comment'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  // Add your share action here
                                },
                                icon: Icon(Icons.share),
                                label: Text('Share'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: cardsData.length,
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
      currentIndex: 2,
        onTap: (index){
        print('current index $index');
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info,color: Colors.black), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism,color: Colors.black), label: 'Donation'),
          BottomNavigationBarItem(icon: Icon(Icons.event,color: Colors.black), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.work,color: Colors.black), label: 'Job'),
        ],
    ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
