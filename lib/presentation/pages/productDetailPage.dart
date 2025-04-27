import 'package:flutter/material.dart';
import 'package:rafsakaos_app/presentation/pages/orderPage.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final int price;
  final String description;
  final String imagePath;

  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  String selectedSize = 'S';
  Color? selectedColor;
  String? uploadedImagePath;

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<Color> colors = [
    Colors.black,
    Colors.green,
    Colors.amber,
    Colors.white,
  ];

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  Future<void> pickImage() async {
    setState(() {
      uploadedImagePath = 'assets/images/sample_design.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.price * quantity;

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp. $totalPrice',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF384188),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Pilih Ukuran',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: sizes.map((size) {
                  bool isSelected = selectedSize == size;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(size),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      selectedColor: Colors.indigo.shade100,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              const Text(
                'Pilih Warna',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: colors.map((color) {
                  bool isSelected = selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Color(0xFF384188), width: 3)
                            : Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              const Text(
                'Tambahkan desain anda',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: uploadedImagePath == null
                      ? const Center(
                    child: Icon(Icons.add_photo_alternate_outlined, size: 50, color: Color(0xFF384188)),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      uploadedImagePath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  IconButton(
                    onPressed: decrement,
                    icon: const Icon(Icons.remove),
                    color: Colors.indigo,
                    iconSize: 30,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: increment,
                    icon: const Icon(Icons.add),
                    color: Color(0xFF384188),
                    iconSize: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF384188),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (selectedSize == null || selectedColor == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Silakan pilih ukuran dan warna.'),
                            ),
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(
                              productName: widget.title,
                              productPrice: widget.price,
                              productDescription: widget.description,
                              productImage: widget.imagePath,
                              selectedSize: selectedSize,
                              selectedColor: selectedColor!,
                              uploadedImagePath: uploadedImagePath,
                              quantity: quantity,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Lanjutkan Pemesanan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}