import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_detail_page.dart';
import 'login_page.dart';
import 'cart_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace Hardware',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text("Marketplace Hardware"),
      ),

            body: [
        const HomeContent(),
        const CartPage(),
        const ProfilePage(),
      ][currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Keranjang",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Future<void> buyNow(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!context.mounted) return;

    String? token = prefs.getString("token");

    if (token == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage(fromCheckout: true)),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Lanjut ke Checkout")));
  }

  @override
  Widget build(BuildContext context) {
    final List<String> bannerImages = [
      "assets/images/banner1.png",
      "assets/images/banner2.jpg",
      "assets/images/banner3.jpg",
      "assets/images/banner4.jpg",
      "assets/images/banner5.jpg",
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // SEARCH
          Padding(
            padding: const EdgeInsets.all(15),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),

              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Cari Hardware Komputer...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // BANNER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),

            child: CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 1,
                autoPlay: true,
              ),

              items: bannerImages.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // KATEGORI
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Kategori",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 110,

            child: ListView(
              scrollDirection: Axis.horizontal,

              padding: const EdgeInsets.symmetric(horizontal: 10),

              children: const [
                CategoryItem(icon: Icons.memory, title: "Processor"),

                CategoryItem(icon: Icons.developer_board, title: "VGA Card"),

                CategoryItem(icon: Icons.storage, title: "Storage"),

                CategoryItem(icon: Icons.monitor, title: "Monitor"),

                CategoryItem(icon: Icons.memory, title: "RAM"),

                CategoryItem(icon: Icons.keyboard, title: "Gaming"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // PRODUK
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),

            child: Text(
              "Produk Terbaru",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          GridView.count(
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            crossAxisCount: 2,

            childAspectRatio: 0.65,

            padding: const EdgeInsets.all(10),

            children: [
              ProductCard(
                name: "RTX 4060",
                price: "Rp 6.500.000",
                onBuy: () {
                  buyNow(context);
                },
              ),

              ProductCard(
                name: "Ryzen 7 5700X",
                price: "Rp 3.200.000",
                onBuy: () {
                  buyNow(context);
                },
              ),

              ProductCard(
                name: "SSD NVME 1TB",
                price: "Rp 1.100.000",
                onBuy: () {
                  buyNow(context);
                },
              ),

              ProductCard(
                name: "Monitor 24 Inch",
                price: "Rp 1.800.000",
                onBuy: () {
                  buyNow(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.symmetric(horizontal: 5),

      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFFFE0B2),

            child: Icon(icon, color: Colors.deepOrange, size: 30),
          ),

          const SizedBox(height: 5),

          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final VoidCallback onBuy;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(name: name, price: price),
          ),
        );
      },

      child: Card(
        elevation: 3,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),

                child: const Icon(Icons.computer, size: 60, color: Colors.grey),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),

              child: Text(
                name,
                textAlign: TextAlign.center,

                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Text(
              price,

              style: const TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 120,

              child: ElevatedButton(
                onPressed: onBuy,
                child: const Text("Beli"),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          SizedBox(height: 15),

          Text(
            "User Marketplace",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Text("user@gmail.com", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
