import 'package:flutter/material.dart';

class GoogleMapReview extends StatelessWidget {
  const GoogleMapReview({super.key});

  // Praktikum 2: Button helper
  Widget _buildButton(IconData icon, String title) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  // Praktikum 1: Title section
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    "Wisata Lembah & Sungai Perbukitan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  "Nusa Tenggara Timur, Indonesia",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.red),
              SizedBox(width: 4),
              Text("41"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter layout demo')),
      // Praktikum 4: Menggunakan ListView pengganti Column
      body: ListView(
        children: [
          // Praktikum 4: Aktif
          Image.asset(
            "assets/wisata.jpg",
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),

          // Praktikum 1: Aktif
          _buildTitle(),

          // Praktikum 2: Aktif
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(Icons.call, "CALL"),
                _buildButton(Icons.near_me, "ROUTE"),
                _buildButton(Icons.share, "SHARE"),
              ],
            ),
          ),

          // Praktikum 3: Aktif (Lorem Ipsum)
          const Padding(
            padding: EdgeInsets.all(32.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
