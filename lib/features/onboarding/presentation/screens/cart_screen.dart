import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items - in production, use Provider/Bloc for state management
  List<CartItem> cartItems = [
    CartItem(
      book: BookModel(
        title: 'Americanah',
        author: 'Chimamanda Ngozi Adichie',
        imagePath: 'assets/images/americanah.jpg',
        price: 5500,
        category: 'Fiction',
        description: 'A powerful story about love and identity.',
      ),
      quantity: 1,
    ),
    CartItem(
      book: BookModel(
        title: 'Things Fall Apart',
        author: 'Chinua Achebe',
        imagePath: 'assets/images/things_fall_apart.jpg',
        price: 3500,
        category: 'Fiction',
        description: 'A classic Nigerian novel.',
      ),
      quantity: 2,
    ),
  ];

  double get subtotal {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.book.price * item.quantity),
    );
  }

  double get shipping => cartItems.isEmpty ? 0 : 1500;
  double get total => subtotal + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  cartItems.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cart cleared')),
                );
              },
              child: Text(
                'Clear All',
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return _buildCartItem(cartItems[index], index);
                    },
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add books to get started',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade900,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Start Shopping',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Book Cover
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item.book.imagePath,
              width: 70,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 100,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.book, color: Colors.grey.shade600),
                );
              },
            ),
          ),
          const SizedBox(width: 16),

          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.book.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.book.author,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '₦${item.book.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    const Spacer(),
                    // Quantity Controls
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) {
                                  item.quantity--;
                                } else {
                                  cartItems.removeAt(index);
                                }
                              });
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: () {
                              setState(() {
                                item.quantity++;
                              });
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete Button
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
            onPressed: () {
              setState(() {
                cartItems.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Price Breakdown
            _buildPriceRow('Subtotal', subtotal),
            const SizedBox(height: 12),
            _buildPriceRow('Shipping', shipping),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 12),
            _buildPriceRow('Total', total, isTotal: true),
            const SizedBox(height: 20),

            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showCheckoutDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? Colors.black87 : Colors.grey.shade700,
          ),
        ),
        Text(
          '₦${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.green.shade900 : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Checkout'),
        content: const Text(
          'Payment integration coming soon! Your order will be processed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                cartItems.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order placed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade900,
            ),
            child: const Text('Confirm Order'),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final BookModel book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });
}