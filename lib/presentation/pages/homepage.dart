import 'package:flutter/material.dart';
import 'package:rafsakaos_app/presentation/pages/productDetailPage.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onProfileTap;
  const HomePage({Key? key, required this.onProfileTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'title': 'Bahan Denim',
        'imagePath': 'assets/images/denim.jpg',
        'price': 120000,
        'description': 'Bahan denim berkualitas tinggi, cocok untuk jaket dan celana.'
      },
      {
        'title': 'Bahan Rayon',
        'imagePath': 'assets/images/rayon.jpg',
        'price': 85000,
        'description': 'Bahan rayon lembut dan adem, cocok untuk pakaian musim panas.'
      },
      {
        'title': 'Bahan Katun',
        'imagePath': 'assets/images/katun.jpg',
        'price': 100000,
        'description': 'Bahan katun serbaguna, nyaman dipakai sehari-hari.'
      },
      {
        'title': 'Bahan Nilon',
        'imagePath': 'assets/images/nilon.jpg',
        'price': 95000,
        'description': 'Bahan nilon tahan air, cocok untuk jaket outdoor.'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi, Selamat Datang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: onProfileTap,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Bahan',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Promo Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/promo.jpg',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '20%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Dapatkan\nCashback',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Rekomendasi
              const Text(
                'Rekomendasi Untuk Anda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Grid Produk
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return buildProductCard(
                    context,
                    product['title'],
                    product['imagePath'],
                    product['price'],
                    product['description'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(BuildContext context, String title, String imagePath, int price, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              title: title,
              price: price,
              description: description,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star_border, size: 16, color: Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp.$price',
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
