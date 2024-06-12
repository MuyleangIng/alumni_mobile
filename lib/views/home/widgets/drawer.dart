import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Change this to your desired color
            ),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.network(
                  'https://yt3.ggpht.com/i_aP_4vPJucAm-0LC7zrnbgGQdNLtEVbdPAfTDom6c8GYPyKpjxw2639gak6lPrJ_ozm4JGZ=s88-c-k-c0x00ffffff-no-rj'),
            ),
            accountName: Text('MuyleangIng'),
            accountEmail: Text('muyleanging@gmail.com'),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.favorite),
            title: Text('Profile'),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.favorite),
            title: Text('Dashboard'),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.favorite),
            title: Text('Activity'),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.favorite),
            title: Text('Analytics'),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cardsData = [
      // Your card data here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni'),
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          // Your CustomScrollView slivers here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set the initial index of the bottom navigation bar
        onTap: (index) {
          print('Current index $index');
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.black),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism, color: Colors.black),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Colors.black),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work, color: Colors.black),
            label: 'Job',
          ),
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
