import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Shimmer Effect',
            style: GoogleFonts.poppins(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: ShimmerList(),
      ),
    );
  }
}

class ListItem {
  final String description;
  final String url;
  final String images;

  ListItem({required this.description, required this.url, required this.images});
}

final List<ListItem> items = [
  ListItem(
    description: 'Permaculture Camping hostal & more ',
    url: 'https://www.behance.net/gallery/135408901/ALDEA-VENADO',
    images: 'assets/Image1.png',
  ),
  ListItem(
    description: 'Branding, Redesign & Visual Identity',
    url: 'https://www.behance.net/gallery/164870245/Burguer-Ponto',
    images: 'assets/Image2.png',
  ),
  ListItem(
    images: 'assets/Image3.png',
    description: 'Eating meat is a thing to decompress and release emotions.',
    url: 'https://www.behance.net/gallery/156524781/Meat-Now-Company',
  ),
  ListItem(
    images: 'assets/Image4.png',
    description: 'Woohoop is a leading company in the customized packaging',
    url: 'https://www.behance.net/gallery/197730331/Woohoop',
  ),
  ListItem(
    images: 'assets/Image5.png',
    description: 'Lorem ipsum is placeholder text commonly used in the graphic',
    url: 'https://www.behance.net/gallery/190466121/Hows-Coffee-Packaging-Design',
  ),
  ListItem(
    images: 'assets/Image6.png',
    description: 'Lorem ipsum is placeholder text commonly used in the graphic',
    url: 'https://www.behance.net/gallery/193952673/Design360-Magazine-No105-Award3602023-BEST-100',
  ),
  ListItem(
    images: 'assets/Image7.png',
    description: 'Lorem ipsum is placeholder text commonly used in the graphic',
    url: 'https://www.behance.net/gallery/166243201/Juicy-Fruit',
  ),
  ListItem(
    images: 'assets/Image8.png',
    description: 'Lorem ipsum is placeholder text commonly used in the graphic',
    url: 'https://www.behance.net/gallery/171606499/Outcore',
  ),
  ListItem(
    images: 'assets/Image9.png',
    description: 'Lorem ipsum is placeholder text commonly used in the graphic',
    url: 'https://www.behance.net/gallery/181729429/SNEAKERHEADZ',
  ),
  ListItem(
    images: 'assets/Image10.png',
    description: 'Lorem ipsum is placeholder text commonly used in the graphic',
    url: 'https://www.behance.net/gallery/194723063/Slanted-Special-Issue-GeorgiaArmenia',
  ),
];

class ShimmerList extends StatefulWidget {
  @override
  _ShimmerListState createState() => _ShimmerListState();
}

class _ShimmerListState extends State<ShimmerList> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a network call
    Timer(Duration(seconds: 10), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading ? _buildShimmerList() : _buildContentList(),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 120.0,
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 13.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: 7.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 7.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 191, 189, 189).withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _launchURL(item.url),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            item.images,
                            semanticLabel: item.description,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.description,
                      style: GoogleFonts.poppins(
                          fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
