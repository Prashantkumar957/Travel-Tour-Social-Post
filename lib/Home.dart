import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Addpost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert'; // For base64 decoding

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerSection(context),
            _socialPostsFromFirestore(), // Changed to fetch data from Firestore
          ],
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      height: 280,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Addpost()),
                  );
                },
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  weight: 2,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 7),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://img.favpng.com/13/19/24/globe-world-map-earth-png-favpng-5zGS0gkghPnnyWSc8sErgHCXd.jpg",
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
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
            style: GoogleFonts.lato(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialPostsFromFirestore() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Posts').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No posts available.'));
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String username = data['username'] ?? 'Unknown User';
            String caption = data['caption'] ?? 'No Caption';
            String location = data['location'] ?? 'Unknown Location';
            String base64Image = data['image'] ?? '';

            return _socialPost(username, base64Image, caption, location);
          }).toList(),
        );
      },
    );
  }

  Widget _socialPost(String username, String base64Image, String caption, String location) {
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
                username, // Use username from Firestore
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          base64Image.isNotEmpty
              ? Image.memory(base64Decode(base64Image)) // Decode base64 and show image
              : Container(), // Show nothing if no image
          SizedBox(height: 10),
          Text(
            caption, // Use caption from Firestore
            style: TextStyle(fontSize: 15, color: Colors.black),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  location, //Use location from firestore
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