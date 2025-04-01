import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';  // Firestore database
import 'package:firebase_storage/firebase_storage.dart';  // Firebase Storage for image upload
import 'package:image_picker/image_picker.dart';  // Allows selecting images from gallery or camera
import 'package:flutter/material.dart';  // Flutter UI framework

class Addpost extends StatefulWidget {
  @override
  _AddpostState createState() => _AddpostState();
}


class _AddpostState extends State<Addpost> {

final TextEditingController username =TextEditingController();
final TextEditingController location = TextEditingController();
final TextEditingController caption = TextEditingController();
Future<void> uploadData() async {
  if(username.text.isEmpty ||location.text.isEmpty ||caption.text.isEmpty ){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all fields",style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      ),
    );

   return;
  }
  try {
    await FirebaseFirestore.instance.collection("Posts").add({
      "id" : DateTime.now().millisecondsSinceEpoch.toString(),
    "username": username.text,
    "location": location.text,
      "caption": caption.text,
      "timestamp": FieldValue.serverTimestamp(),


    });
    username.clear();
    location.clear();
    caption.clear();

  } catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$e",style: TextStyle(color: Colors.white,)

      ),
      backgroundColor: Colors.red,
      ),
    );
  }


}

File? _image;
final picker = ImagePicker();
Future<void> _imagePick () async{
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if(pickedFile!=null){
    setState(() {
      _image= File(pickedFile.path);
    });
  }
}
//   final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Post",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Square boundary for image upload
              GestureDetector(
                onTap: _imagePick,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? Icon(
                    Icons.camera_enhance_outlined,
                    size: 50,
                    color: Colors.grey,
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  labelText: "Enter Your Name",
                  prefixIcon: Icon(Icons.person_2_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)

                  ),
                ),
              ),
              SizedBox(height: 10),
               TextField(
                 controller: caption,
                 maxLines: 4,
                
                decoration: InputDecoration(
                  
                  labelText: "Enter Post Caption",
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Location input field
              TextField(
                controller: location,
                decoration: InputDecoration(
                  labelText: "Enter Post Location",
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)

                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: uploadData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  "Submit Post",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
