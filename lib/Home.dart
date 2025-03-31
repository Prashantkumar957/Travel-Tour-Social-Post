import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Traveler Name"),
              accountEmail: Text("traveler@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40.0,
                  color: Colors.black,
                ),
              ),
            ),
            _drawerItem(Icons.home, "Home", () => Navigator.pop(context)),
            _drawerItem(Icons.explore, "Explore Destinations", () {}),
            _drawerItem(Icons.favorite, "Favorite Trips", () {}),
            _drawerItem(Icons.book, "My Bookings", () {}),
            _drawerItem(Icons.chat, "Community", () {}),
            _drawerItem(Icons.settings, "Settings", () {}),
            _drawerItem(Icons.exit_to_app, "Log Out", () {}),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerSection(),
            _socialPost(),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _headerSection() {
    return Container(
      width: double.infinity,
      color: Colors.orange,
      height: 280,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
      backgroundImage: NetworkImage(
      "https://img.favpng.com/13/19/24/globe-world-map-earth-png-favpng-5zGS0gkghPnnyWSc8sErgHCXd.jpg"),
    ),


          Text(
            "Hi User",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Welcome to Travel Tour",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialPost() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/4439/4439947.png"),
              ),
              SizedBox(width: 10),
              Text(
                "Prashant Kumar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "The Taj Mahal, a UNESCO World Heritage Site in Agra, India, is a stunning white marble mausoleum built by Mughal Emperor Shah Jahan in memory of his wife, Mumtaz Mahal.",
            style: TextStyle(fontSize: 15, color: Colors.black),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Amazing view of the Taj Mahal!",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: Icon(Icons.comment, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}