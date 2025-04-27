import 'package:flutter/material.dart';
import 'paymentPage.dart';

class OrderPage extends StatefulWidget {
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productImage;
  final String? selectedSize;
  final Color selectedColor;
  final String? uploadedImagePath;
  final int quantity;

  const OrderPage({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
    this.selectedSize,
    required this.selectedColor,
    this.uploadedImagePath,
    required this.quantity,
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  int deliveryCost = 5000;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.productPrice * widget.quantity;
    final int finalPrice = totalPrice + deliveryCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Pemesanan'),
        backgroundColor: Color(0xFF384188),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.productImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text('Rp. ${widget.productPrice} x ${widget.quantity}'),
                      if (widget.selectedSize != null)
                        Text('Ukuran: ${widget.selectedSize}'),
                      Row(
                        children: [
                          const Text('Warna: '),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.selectedColor,
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '#${widget.selectedColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Input Nama
            const Text('Nama Penerima',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama penerima',
              ),
            ),
            const SizedBox(height: 16),

            // Input Lokasi Pengiriman
            const Text('Lokasi Pengiriman',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _locationController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan alamat pengiriman lengkap',
              ),
            ),
            const SizedBox(height: 24),

            // Rincian Pembayaran
            const Text('Rincian Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pesanan:'),
                Text('Rp. $totalPrice'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pengantaran:'),
                Text('Rp. $deliveryCost'),
              ],
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Rp. $finalPrice',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF384188),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _locationController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          deliveryCost: deliveryCost,
                          quantity: widget.quantity,
                          recipientName: _nameController.text,
                          deliveryLocation: _locationController.text,
                          productImage: widget.productImage,
                          selectedColor: widget.selectedColor,
                          selectedSize: widget.selectedSize,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Harap isi nama dan lokasi pengiriman.')),
                    );
                  }
                },
                child: const Text(
                  'Pesan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}