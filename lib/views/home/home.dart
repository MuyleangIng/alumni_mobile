import 'package:Alumni/views/home/widgets/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class Post {
  final String name;
  final String status;
  final String image;
  int likes;
  List<Comment> comments;

  Post({
    required this.name,
    required this.status,
    required this.image,
    this.likes = 0,
    List<Comment>? comments,
  }) : comments = comments ?? [];
}

class Comment {
  final String user;
  final String text;
  List<Comment> replies;

  Comment({
    required this.user,
    required this.text,
    List<Comment>? replies,
  }) : replies = replies ?? [];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> posts = [
    Post(
      name: 'MuyleangIng',
      status: 'Status message or description here',
      image: 'assets/images/2.jpg',
      likes: 10,
      comments: [
        Comment(
          user: 'Jane Doe',
          text: 'Nice post!',
          replies: [
            Comment(user: 'John Doe', text: 'I agree!'),
          ],
        ),
        Comment(
          user: 'Sam Smith',
          text: 'Great job!',
        ),
      ],
    ),
    Post(
      name: 'John Doe',
      status: 'Another status message here',
      image: 'assets/images/rith.jpg',
      likes: 20,
      comments: [],
    ),
    Post(
      name: 'Jane Smith',
      status: 'Yet another status message here',
      image: 'assets/images/2.jpg',
      likes: 5,
      comments: [],
    ),
    Post(
      name: 'Alex Johnson',
      status: 'This is a different status message',
      image: 'assets/images/1.jpg',
      likes: 15,
      comments: [],
    ),
  ];

  void _likePost(int index) {
    setState(() {
      posts[index].likes++;
    });
  }

  void _commentOnPost(int postIndex, String comment) {
    setState(() {
      posts[postIndex].comments.add(Comment(user: 'Current User', text: comment));
    });
  }

  void _replyToComment(int postIndex, int commentIndex, String reply) {
    setState(() {
      posts[postIndex].comments[commentIndex].replies.add(Comment(user: 'Current User', text: reply));
    });
  }

  void _showCommentDialog(BuildContext context, int postIndex) {
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
                _commentOnPost(postIndex, commentController.text);
                Navigator.of(context).pop();
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }

  void _showReplyDialog(BuildContext context, int postIndex, int commentIndex) {
    final TextEditingController replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reply to Comment'),
          content: TextField(
            controller: replyController,
            decoration: InputDecoration(hintText: 'Enter your reply'),
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
                _replyToComment(postIndex, commentIndex, replyController.text);
                Navigator.of(context).pop();
              },
              child: Text('Reply'),
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
                  'assets/images/alumni-text.jpg',
                  height: 30,
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
                radius: 20,
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final post = posts[index];
                return PostCard(
                  post: post,
                  onLike: () => _likePost(index),
                  onComment: () => _showCommentDialog(context, index),
                  onReply: (commentIndex) => _showReplyDialog(context, index, commentIndex),
                );
              },
              childCount: posts.length,
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

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final Function(int) onReply;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onReply,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _visibleComments = 1;
  Map<int, int> _visibleReplies = {};

  void _showMoreComments() {
    setState(() {
      _visibleComments += 1;
    });
  }

  void _showMoreReplies(int commentIndex) {
    setState(() {
      _visibleReplies[commentIndex] = (_visibleReplies[commentIndex] ?? 1) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text(widget.post.name),
                subtitle: Text(widget.post.status),
              ),
              SizedBox(height: 10),
              Text(
                'This is a detailed description that can span multiple lines and gives more information about the status.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Image.asset(widget.post.image),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '${widget.post.likes} Likes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: widget.onLike,
                    icon: Icon(Icons.thumb_up),
                    label: Text('Like'),
                  ),
                  TextButton.icon(
                    onPressed: widget.onComment,
                    icon: Icon(Icons.comment),
                    label: Text('Comment'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                    label: Text('Share'),
                  ),
                ],
              ),
              Text(
                'Comments (${widget.post.comments.length})',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (var i = 0;
              i <
                  (_visibleComments < widget.post.comments.length
                      ? _visibleComments
                      : widget.post.comments.length);
              i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                          AssetImage('assets/icon/app_icon.png'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.post.comments[i].user,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(widget.post.comments[i].text),
                        ),
                        if (widget.post.comments[i].replies.isNotEmpty)
                          TextButton(
                            onPressed: () => _showMoreReplies(i),
                            child: Text('See Replies'),
                          ),
                      ],
                    ),
                    if (_visibleReplies[i] != null)
                      for (var j = 0;
                      j <
                          (_visibleReplies[i]! <
                              widget.post.comments[i].replies.length
                              ? _visibleReplies[i]!
                              : widget.post.comments[i].replies.length);
                      j++)
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                AssetImage('assets/icon/app_icon.png'),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.post.comments[i].replies[j].user,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                    widget.post.comments[i].replies[j].text),
                              ),
                            ],
                          ),
                        ),
                    if (_visibleReplies[i] != null &&
                        _visibleReplies[i]! <
                            widget.post.comments[i].replies.length)
                      TextButton(
                        onPressed: () => _showMoreReplies(i),
                        child: Text('See More Replies'),
                      ),
                  ],
                ),
              if (_visibleComments < widget.post.comments.length)
                TextButton(
                  onPressed: _showMoreComments,
                  child: Text('See More Comments'),
                ),
            ],
          ),
        ),
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
