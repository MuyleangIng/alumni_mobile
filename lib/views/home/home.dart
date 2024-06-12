import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> cardsData = [
    {
      'name': 'MuyleangIng',
      'status': 'Status message or description here',
      'image': 'assets/images/2.jpg',
      'likes': 10,
      'comments': 5,
    },
    {
      'name': 'John Doe',
      'status': 'Another status message here',
      'image': 'assets/images/rith.jpg',
      'likes': 20,
      'comments': 2,
    },
    {
      'name': 'Jane Smith',
      'status': 'Yet another status message here',
      'image': 'assets/images/2.jpg',
      'likes': 5,
      'comments': 1,
    },
    {
      'name': 'Alex Johnson',
      'status': 'This is a different status message',
      'image': 'assets/images/1.jpg',
      'likes': 15,
      'comments': 3,
    },
  ];

  void _likePost(int index) {
    setState(() {
      cardsData[index]['likes']++;
    });
  }

  void _commentOnPost(int index, String comment) {
    setState(() {
      cardsData[index]['comments']++;
      // Here you can also store the comment if needed
    });
  }

  void _sharePost(int index) {
    // Implement share functionality here
    print('Post shared');
  }

  void _showCommentDialog(BuildContext context, int index) {
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _commentOnPost(index, commentController.text);
                Navigator.of(context).pop();
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 6.0),
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
                radius: 20, // Set the radius to adjust the size of the CircleAvatar
              ),
            )
          ],
        ),
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
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
                                onPressed: () => _likePost(index),
                                icon: Icon(Icons.thumb_up),
                                label: Text('Like'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  _showCommentDialog(context, index);
                                },
                                icon: Icon(Icons.comment),
                                label: Text('Comment'),
                              ),
                              TextButton.icon(
                                onPressed: () => _sharePost(index),
                                icon: Icon(Icons.share),
                                label: Text('Share'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${card['likes']} Likes'),
                              Text('${card['comments']} Comments'),
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
        onTap: (index) {
          print('current index $index');
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info, color: Colors.black), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism, color: Colors.black), label: 'Donation'),
          BottomNavigationBarItem(icon: Icon(Icons.event, color: Colors.black), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.work, color: Colors.black), label: 'Job'),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
