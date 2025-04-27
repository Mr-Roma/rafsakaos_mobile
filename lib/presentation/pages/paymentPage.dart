import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String productName;
  final int productPrice;
  final int deliveryCost;
  final int quantity;
  final String recipientName;
  final String deliveryLocation;
  final String productImage;
  final String? selectedSize;
  final Color selectedColor;

  const PaymentPage({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.deliveryCost,
    required this.quantity,
    required this.recipientName,
    required this.deliveryLocation,
    required this.productImage,
    required this.selectedColor,
    this.selectedSize,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  bool showCreditCards = false;

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.productPrice * widget.quantity;
    final int finalPrice = totalPrice + widget.deliveryCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
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
                      const Icon(Icons.image_not_supported, size: 40),
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
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

            const Text('Informasi Penerima', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Nama: ${widget.recipientName}'),
            Text('Alamat: ${widget.deliveryLocation}'),
            const SizedBox(height: 24),

            const Text('Pilih Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('QR'),
              onTap: () => setState(() => selectedPaymentMethod = 'qr'),
              trailing: selectedPaymentMethod == 'qr'
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Kartu Debit'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => setState(() => selectedPaymentMethod = 'debit'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Kartu Kredit'),
              trailing: Icon(showCreditCards ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onTap: () => setState(() => showCreditCards = !showCreditCards),
            ),
            if (showCreditCards) ...[
              RadioListTile<String>(
                title: const Text('Axis Bank xxxx68'),
                value: 'axis',
                groupValue: selectedPaymentMethod,
                onChanged: (value) => setState(() => selectedPaymentMethod = value),
              ),
              RadioListTile<String>(
                title: const Text('Vyx Bank xxxx54'),
                value: 'vyx',
                groupValue: selectedPaymentMethod,
                onChanged: (value) => setState(() => selectedPaymentMethod = value),
              ),
            ],
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambahkan Metode Pembayaran'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menuju halaman tambah metode pembayaran')),
              ),
            ),
            const SizedBox(height: 24),

            const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pesanan:'),
                Text('Rp. $totalPrice'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Biaya Pengiriman:'),
                Text('Rp. ${widget.deliveryCost}'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Rp. $finalPrice', style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  if (selectedPaymentMethod != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionSuccessPage(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih metode pembayaran terlebih dahulu')),
                    );
                  }
                },
                child: const Text(
                  'Bayar',
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

class TransactionLoadingPage extends StatelessWidget {
  const TransactionLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Loading....',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionSuccessPage extends StatelessWidget {
  const TransactionSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Yeayyy!!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Transaksimu Berhasil',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}