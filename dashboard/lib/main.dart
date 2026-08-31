import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ======================================================
// TASK 1: APP SETUP (With Swiggy / Zomato Onboarding & Red Theme)
// ======================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Express',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          primary: Colors.red.shade700,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ======================================================
// LOGIN SCREEN (Swiggy / Zomato Consumer Onboarding)
// ======================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: '9876543210');
  String _errorMessage = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin({String name = 'Foodie Alex'}) {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your mobile number or email';
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(userName: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Hero Image Banner
            Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1000&q=80',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 280,
                    color: Colors.red.shade700,
                    child: const Center(
                      child: Icon(Icons.fastfood, size: 70, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () => _handleLogin(name: 'Foodie'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Skip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_ios,
                                  size: 11, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'FOOD EXPRESS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Hungry? We deliver in minutes 🍕',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Order from thousands of top restaurants near you',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Form Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login or Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Enter your phone number or email to continue',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              child: Row(
                                children: [
                                  const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                                  const SizedBox(width: 6),
                                  const Text(
                                    '+91',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.shade600),
                                ],
                              ),
                            ),
                            Container(
                              height: 28,
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Enter Mobile Number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 14),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (_errorMessage.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _handleLogin(name: 'Alex'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR CONTINUE WITH',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _handleLogin(name: 'Google User'),
                              icon: const Icon(Icons.g_mobiledata_rounded,
                                  size: 26, color: Colors.red),
                              label: const Text(
                                'Google',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _handleLogin(name: 'Guest Foodie'),
                              icon: const Icon(Icons.email_outlined,
                                  size: 18, color: Colors.black87),
                              label: const Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Center(
                        child: Text(
                          'By continuing, you agree to our Terms of Service & Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
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

// ======================================================
// TASK 2: DYNAMIC DASHBOARD (With Interactive Cart & State)
// ======================================================
class DashboardScreen extends StatefulWidget {
  final String userName;

  const DashboardScreen({
    super.key,
    this.userName = 'Alex',
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedNav = 'Explore Food';
  final Map<String, int> _cart = {};
  final Set<String> _favorites = {};

  // Dynamic user orders list reflecting user's actual order history
  int _nextOrderId = 1007;
  final List<Map<String, String>> _recentOrders = [
    {
      'id': '#1006',
      'food': 'Paneer Butter Masala + Roti',
      'status': 'Delivered',
      'price': '₹379',
      'time': 'Yesterday',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&q=80',
    },
    {
      'id': '#1005',
      'food': 'Burger + Pasta',
      'status': 'Preparing',
      'price': '₹488',
      'time': 'Today, 12:40 PM',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&q=80',
    },
    {
      'id': '#1003',
      'food': 'Extra Cheese Paneer Tandoori Pizza',
      'status': 'Delivered',
      'price': '₹449',
      'time': '2 days ago',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&q=80',
    },
  ];

  int get _totalCartItems => _cart.values.fold(0, (sum, qty) => sum + qty);

  int get _totalCartPrice {
    int total = 0;
    _cart.forEach((foodName, qty) {
      int unitPrice = 250;
      if (foodName.contains('Pizza') && foodName.contains('Tandoori')) {
        unitPrice = 449;
      } else if (foodName.contains('Lobster')) {
        unitPrice = 599;
      } else if (foodName.contains('Pizza')) {
        unitPrice = 349;
      } else if (foodName.contains('Biryani')) {
        unitPrice = 319;
      } else if (foodName.contains('Pasta')) {
        unitPrice = 259;
      } else if (foodName.contains('Burger')) {
        unitPrice = 229;
      } else if (foodName.contains('Noodles')) {
        unitPrice = 209;
      } else if (foodName.contains('Salad')) {
        unitPrice = 199;
      } else if (foodName.contains('Sandwich')) {
        unitPrice = 179;
      }
      total += unitPrice * qty;
    });
    return total;
  }

  void _addToCart(String foodName) {
    setState(() {
      _cart[foodName] = (_cart[foodName] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $foodName (Qty: ${_cart[foodName]}) to cart!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'CHECKOUT',
          textColor: Colors.white,
          onPressed: _showCartBottomSheet,
        ),
      ),
    );
  }

  void _removeFromCart(String foodName) {
    setState(() {
      if (_cart.containsKey(foodName)) {
        if (_cart[foodName]! > 1) {
          _cart[foodName] = _cart[foodName]! - 1;
        } else {
          _cart.remove(foodName);
        }
      }
    });
  }

  void _toggleFavorite(String foodName) {
    setState(() {
      if (_favorites.contains(foodName)) {
        _favorites.remove(foodName);
      } else {
        _favorites.add(foodName);
      }
    });
  }

  // Places the user's actual cart order and updates Recent Orders list
  void _placeOrder() {
    if (_cart.isEmpty) return;

    // Create summary of what the user actually ordered
    final orderSummary = _cart.entries
        .map((e) => '${e.value > 1 ? '${e.value}x ' : ''}${e.key}')
        .join(' + ');

    // Determine the hero photo of the first ordered item
    final firstItem = _cart.keys.first;
    String orderImage =
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300&q=80';
    if (firstItem.contains('Pizza') && firstItem.contains('Tandoori')) {
      orderImage =
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&q=80';
    } else if (firstItem.contains('Burger')) {
      orderImage =
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&q=80';
    } else if (firstItem.contains('Biryani')) {
      orderImage =
          'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=300&q=80';
    } else if (firstItem.contains('Pasta')) {
      orderImage =
          'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=300&q=80';
    } else if (firstItem.contains('Salad')) {
      orderImage =
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500&q=80';
    } else if (firstItem.contains('Sandwich')) {
      orderImage =
          'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=500&q=80';
    } else if (firstItem.contains('Noodles')) {
      orderImage =
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500&q=80';
    } else if (firstItem.contains('Lobster')) {
      orderImage =
          'https://images.unsplash.com/photo-1559737558-245cb3848b88?w=500&q=80';
    }

    final newOrder = {
      'id': '#$_nextOrderId',
      'food': orderSummary,
      'status': 'Preparing',
      'price': '₹$_totalCartPrice',
      'time': 'Just now',
      'image': orderImage,
    };

    setState(() {
      _nextOrderId++;
      _recentOrders.insert(0, newOrder);
      _cart.clear();
    });
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'Your Cart ($_totalCartItems items)',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                if (_cart.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_shopping_cart,
                              size: 60, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: _cart.entries.map((entry) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              entry.key,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Qty: ${entry.value}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline,
                                      color: Colors.red),
                                  onPressed: () {
                                    _removeFromCart(entry.key);
                                    setModalState(() {});
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  '${entry.value}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline,
                                      color: Colors.green),
                                  onPressed: () {
                                    _addToCart(entry.key);
                                    setModalState(() {});
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (_cart.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'To Pay:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹$_totalCartPrice',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _placeOrder();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      '🎉 Order Placed! Your ordered food is now in Recent Orders.'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Place Order (Pay Now)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    return Scaffold(
      // Mobile AppBar with Hamburger Menu to open Sidebar Drawer
      appBar: isMobile
          ? AppBar(
              title: const Text(
                'Food Express',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined),
                      onPressed: _showCartBottomSheet,
                    ),
                    if (_totalCartItems > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$_totalCartItems',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => const SettingsScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.red.shade100,
                      child: Icon(Icons.person, size: 18, color: Colors.red.shade900),
                    ),
                  ),
                ),
              ],
            )
          : null,
      // Drawer on mobile providing access to full sidebar
      drawer: isMobile
          ? Drawer(
              child: SideMenu(
                selectedNav: _selectedNav,
                cartCount: _totalCartItems,
                favoriteCount: _favorites.length,
                onSelect: (nav) {
                  setState(() {
                    _selectedNav = nav;
                  });
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      // Floating Action Button for AI Food Assistant
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const StatisticsChatbotSheet(),
          );
        },
        backgroundColor: Colors.red.shade700,
        icon: const Icon(Icons.smart_toy_rounded, color: Colors.white),
        label: const Text(
          'AI Food Bot',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Sticky bottom cart banner if items in cart
      bottomNavigationBar: _totalCartItems > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$_totalCartItems ITEMS IN CART',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹$_totalCartPrice',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _showCartBottomSheet,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('View Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green.shade900,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Row(
        children: [
          // Sidebar on Desktop / Tablet
          if (!isMobile)
            SizedBox(
              width: isDesktop ? 260 : 210,
              child: SideMenu(
                selectedNav: _selectedNav,
                cartCount: _totalCartItems,
                favoriteCount: _favorites.length,
                onSelect: (nav) {
                  setState(() {
                    _selectedNav = nav;
                  });
                },
              ),
            ),

          // Main Dashboard Area
          Expanded(
            child: DashboardContent(
              isMobile: isMobile,
              isTablet: isTablet,
              isDesktop: isDesktop,
              userName: widget.userName,
              cart: _cart,
              favorites: _favorites,
              recentOrders: _recentOrders,
              onAddToCart: _addToCart,
              onRemoveFromCart: _removeFromCart,
              onToggleFavorite: _toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// TASK 3: EXPANDED & CATEGORIZED SIDEBAR (Multi-Section)
// ======================================================
class SideMenu extends StatelessWidget {
  final String selectedNav;
  final int cartCount;
  final int favoriteCount;
  final Function(String) onSelect;

  const SideMenu({
    super.key,
    required this.selectedNav,
    required this.cartCount,
    required this.favoriteCount,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Brand Logo
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_rounded,
                      size: 32,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Food Express',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Delivering Fresh & Fast 🛵',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Categorized Sidebar Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                // SECTION 1: DISCOVER
                _buildSectionHeader('DISCOVER & ORDER'),
                _buildMenuItem(
                  context,
                  icon: Icons.explore_outlined,
                  activeIcon: Icons.explore,
                  title: 'Explore Food',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.local_offer_outlined,
                  activeIcon: Icons.local_offer,
                  title: 'Special Deals',
                  badge: '50% OFF',
                  badgeColor: Colors.orange.shade800,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.storefront_outlined,
                  activeIcon: Icons.storefront,
                  title: 'Top Restaurants',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.spa_outlined,
                  activeIcon: Icons.spa,
                  title: 'Healthy & Diet',
                ),

                const SizedBox(height: 14),

                // SECTION 2: MY ORDERS & REWARDS
                _buildSectionHeader('MY ACCOUNT'),
                _buildMenuItem(
                  context,
                  icon: Icons.receipt_long_outlined,
                  activeIcon: Icons.receipt_long,
                  title: 'Live Orders',
                  badge: '2 Active',
                  badgeColor: Colors.green.shade700,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.favorite_border,
                  activeIcon: Icons.favorite,
                  title: 'Favorites',
                  badge: favoriteCount > 0 ? '$favoriteCount' : null,
                  badgeColor: Colors.red.shade700,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.account_balance_wallet_outlined,
                  activeIcon: Icons.account_balance_wallet,
                  title: 'Food Wallet',
                  badge: '₹450',
                  badgeColor: Colors.purple.shade700,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.history,
                  activeIcon: Icons.history_toggle_off,
                  title: 'Order History',
                ),

                const SizedBox(height: 14),

                // SECTION 3: PREFERENCES & SUPPORT
                _buildSectionHeader('SUPPORT & SETTINGS'),
                _buildMenuItem(
                  context,
                  icon: Icons.location_on_outlined,
                  activeIcon: Icons.location_on,
                  title: 'Saved Addresses',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.support_agent_outlined,
                  activeIcon: Icons.support_agent,
                  title: '24/7 Live Support',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                  title: 'Settings',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // User Profile & Logout Bottom Tile
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              backgroundColor: Colors.red.shade100,
              child: Icon(Icons.person, color: Colors.red.shade900),
            ),
            title: const Text(
              'Alex Morgan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            subtitle: const Text('Gold Member ★',
                style: TextStyle(fontSize: 10, color: Colors.amber)),
            trailing: IconButton(
              icon: const Icon(Icons.logout, color: Colors.red, size: 20),
              tooltip: 'Log Out',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String title,
    String? badge,
    Color? badgeColor,
  }) {
    final isSelected = selectedNav == title;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? Colors.red.shade700 : Colors.grey.shade700,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.red.shade900 : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor ?? Colors.red.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () {
          if (title == 'Explore Food') {
            onSelect(title);
          } else if (title == 'Special Deals') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SpecialDealsScreen()),
            );
          } else if (title == 'Top Restaurants') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TopRestaurantsScreen()),
            );
          } else if (title == 'Healthy & Diet') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HealthyDietScreen()),
            );
          } else if (title == 'Live Orders') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LiveOrdersScreen()),
            );
          } else if (title == 'Favorites') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            );
          } else if (title == 'Food Wallet') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WalletScreen()),
            );
          } else if (title == 'Order History') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
            );
          } else if (title == 'Saved Addresses') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedAddressesScreen()),
            );
          } else if (title == '24/7 Live Support') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupportScreen()),
            );
          } else if (title == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(title: title),
              ),
            );
          }
        },
      ),
    );
  }
}

// ======================================================
// TASK 5: FOOD DATA MODEL & INTERACTIVE FOOD GRID
// ======================================================
class FoodItem {
  final String name;
  final String category;
  final IconData icon;
  final String imageUrl;
  final String price;
  final int rawPrice;
  final double rating;
  final String prepTime;

  const FoodItem({
    required this.name,
    required this.category,
    required this.icon,
    required this.imageUrl,
    required this.price,
    required this.rawPrice,
    required this.rating,
    this.prepTime = '20-25 mins',
  });
}

class FoodGrid extends StatefulWidget {
  final bool isMobile;
  final bool isTablet;
  final Map<String, int> cart;
  final Set<String> favorites;
  final Function(String) onAddToCart;
  final Function(String) onRemoveFromCart;
  final Function(String) onToggleFavorite;

  const FoodGrid({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.cart,
    required this.favorites,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onToggleFavorite,
  });

  @override
  State<FoodGrid> createState() => _FoodGridState();
}

class _FoodGridState extends State<FoodGrid> {
  final List<FoodItem> foodList = const [
    FoodItem(
      name: 'Salad',
      category: 'Healthy',
      icon: Icons.eco,
      imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500&q=80',
      price: '₹199',
      rawPrice: 199,
      rating: 4.5,
      prepTime: '15 mins',
    ),
    FoodItem(
      name: 'Burger',
      category: 'Fast Food',
      icon: Icons.lunch_dining,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80',
      price: '₹229',
      rawPrice: 229,
      rating: 4.8,
      prepTime: '20 mins',
    ),
    FoodItem(
      name: 'Pasta',
      category: 'Meals',
      icon: Icons.dinner_dining,
      imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=500&q=80',
      price: '₹259',
      rawPrice: 259,
      rating: 4.2,
      prepTime: '25 mins',
    ),
    FoodItem(
      name: 'Sandwich',
      category: 'Fast Food',
      icon: Icons.bakery_dining,
      imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=500&q=80',
      price: '₹179',
      rawPrice: 179,
      rating: 4.0,
      prepTime: '15 mins',
    ),
    FoodItem(
      name: 'Biryani',
      category: 'Meals',
      icon: Icons.rice_bowl,
      imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500&q=80',
      price: '₹319',
      rawPrice: 319,
      rating: 4.9,
      prepTime: '30 mins',
    ),
    FoodItem(
      name: 'Noodles',
      category: 'Meals',
      icon: Icons.ramen_dining,
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500&q=80',
      price: '₹209',
      rawPrice: 209,
      rating: 4.3,
      prepTime: '20 mins',
    ),
    FoodItem(
      name: 'Pizza',
      category: 'Fast Food',
      icon: Icons.local_pizza,
      imageUrl: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=500&q=80',
      price: '₹349',
      rawPrice: 349,
      rating: 4.7,
      prepTime: '25 mins',
    ),
    // Long Food Name Requirement
    FoodItem(
      name: 'Extra Cheese Paneer Tandoori Pizza',
      category: 'Fast Food',
      icon: Icons.local_pizza,
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&q=80',
      price: '₹449',
      rawPrice: 449,
      rating: 4.9,
      prepTime: '30 mins',
    ),
    FoodItem(
      name: 'Lobster',
      category: 'Meals',
      icon: Icons.set_meal,
      imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500&q=80',
      price: '₹599',
      rawPrice: 599,
      rating: 4.6,
      prepTime: '35 mins',
    ),
  ];

  String searchQuery = '';
  String selectedCategory = 'All';
  String sortBy = 'Recommended';

  final List<String> categories = const [
    'All',
    'Fast Food',
    'Meals',
    'Healthy',
    'Under ₹250',
    'Top Rated ★',
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic
    var filteredFoods = foodList.where((food) {
      final matchesSearch =
          food.name.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = true;
      if (selectedCategory == 'Under ₹250') {
        matchesCategory = food.rawPrice <= 250;
      } else if (selectedCategory == 'Top Rated ★') {
        matchesCategory = food.rating >= 4.5;
      } else if (selectedCategory != 'All') {
        matchesCategory = food.category == selectedCategory;
      }
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort logic
    if (sortBy == 'Price: Low to High') {
      filteredFoods.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    } else if (sortBy == 'Rating: High to Low') {
      filteredFoods.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search and Sort Bar
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search delicious meals (e.g. Pizza, Biryani)...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            // Sort Filter
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: sortBy,
                  icon: const Icon(Icons.sort),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Recommended', child: Text('Recommended')),
                    DropdownMenuItem(
                        value: 'Rating: High to Low',
                        child: Text('Top Rated ★')),
                    DropdownMenuItem(
                        value: 'Price: Low to High',
                        child: Text('Price: Low to High')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        sortBy = val;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Category Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              final isSelected = selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  selectedColor: Colors.red.shade100,
                  checkmarkColor: Colors.red.shade900,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.red.shade900 : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.red.shade400
                          : Colors.grey.shade300,
                    ),
                  ),
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 15),

        // Grid (2 items on mobile, 3 on tablet, 4 on desktop)
        if (filteredFoods.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.search_off, size: 48, color: Colors.grey),
                const SizedBox(height: 10),
                const Text(
                  'No food items match your filter.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      searchQuery = '';
                      selectedCategory = 'All';
                    });
                  },
                  child: const Text('Reset All Filters'),
                ),
              ],
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredFoods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.isMobile
                  ? 2
                  : widget.isTablet
                      ? 3
                      : 4,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: widget.isMobile
                  ? 0.76
                  : widget.isTablet
                      ? 0.85
                      : 0.88,
            ),
            itemBuilder: (context, i) {
              final food = filteredFoods[i];
              final cartQuantity = widget.cart[food.name] ?? 0;
              final isFav = widget.favorites.contains(food.name);

              return FoodCard(
                foodName: food.name,
                price: food.price,
                icon: food.icon,
                imageUrl: food.imageUrl,
                rating: food.rating,
                prepTime: food.prepTime,
                cartQuantity: cartQuantity,
                isFavorite: isFav,
                onAddToCart: () => widget.onAddToCart(food.name),
                onRemoveFromCart: () => widget.onRemoveFromCart(food.name),
                onToggleFavorite: () => widget.onToggleFavorite(food.name),
              );
            },
          ),
      ],
    );
  }
}

// ======================================================
// REUSABLE INTERACTIVE FOOD CARD (With Favorite & Stepper)
// ======================================================
class FoodCard extends StatelessWidget {
  final String foodName;
  final String price;
  final IconData icon;
  final String imageUrl;
  final double rating;
  final String prepTime;
  final int cartQuantity;
  final bool isFavorite;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;
  final VoidCallback onToggleFavorite;

  const FoodCard({
    super.key,
    required this.foodName,
    required this.price,
    required this.icon,
    required this.imageUrl,
    required this.rating,
    required this.prepTime,
    required this.cartQuantity,
    required this.isFavorite,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image with Floating Badges
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.red.shade50,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.red.shade50,
                    child: Center(
                      child: Icon(icon, size: 36, color: Colors.red.shade700),
                    ),
                  ),
                ),
                // Star Rating Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite Heart Button
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 20,
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ),
              ],
            ),
          ),

          // Details & Add to Cart Stepper
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      // Interactive Stepper / Add button
                      if (cartQuantity == 0)
                        InkWell(
                          onTap: onAddToCart,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 12, color: Colors.white),
                                SizedBox(width: 2),
                                Text(
                                  'ADD',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: onRemoveFromCart,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: Icon(Icons.remove,
                                      size: 14, color: Colors.red.shade900),
                                ),
                              ),
                              Text(
                                '$cartQuantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.red.shade900,
                                ),
                              ),
                              InkWell(
                                onTap: onAddToCart,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: Icon(Icons.add,
                                      size: 14, color: Colors.red.shade900),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// TASK 6: RECENT ORDERS (Reflects User's Actual Orders with Status Filter & Reorder)
// ======================================================
class RecentOrders extends StatefulWidget {
  final List<Map<String, String>> orders;
  final Function(String)? onReorder;

  const RecentOrders({
    super.key,
    required this.orders,
    this.onReorder,
  });

  @override
  State<RecentOrders> createState() => _RecentOrdersState();
}

class _RecentOrdersState extends State<RecentOrders> {
  String _selectedStatusFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredOrders = widget.orders.where((order) {
      if (_selectedStatusFilter == 'All') return true;
      return order['status'] == _selectedStatusFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['All', 'Preparing', 'Delivered', 'Cancelled'].map((st) {
              final isSel = _selectedStatusFilter == st;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(st),
                  selected: isSel,
                  selectedColor: Colors.red.shade100,
                  labelStyle: TextStyle(
                    color: isSel ? Colors.red.shade900 : Colors.black87,
                    fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedStatusFilter = st;
                      });
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 10),

        if (filteredOrders.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.receipt_long, size: 40, color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  _selectedStatusFilter == 'All'
                      ? 'No recent orders yet.'
                      : 'No $_selectedStatusFilter orders.',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Add food to your cart to see live orders here!',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              final status = order['status']!;

              Color statusColor = Colors.green;
              if (status == 'Preparing') {
                statusColor = Colors.orange;
              } else if (status == 'Cancelled') {
                statusColor = Colors.red;
              }

              return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      order['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Order ${order['id']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order['time'] ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            order['food']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          order['price'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios,
                          size: 13, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(
                          orderId: order['id']!,
                          foodName: order['food']!,
                          status: order['status']!,
                          price: order['price'] ?? '₹299',
                          time: order['time'] ?? 'Just now',
                          imageUrl: order['image'] ?? '',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}

// ======================================================
// TASK 7: DYNAMIC DASHBOARD CONTENT (Promos, Greetings, Grid)
// ======================================================
class DashboardContent extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final String userName;
  final Map<String, int> cart;
  final Set<String> favorites;
  final List<Map<String, String>> recentOrders;
  final Function(String) onAddToCart;
  final Function(String) onRemoveFromCart;
  final Function(String) onToggleFavorite;

  const DashboardContent({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    required this.userName,
    required this.cart,
    required this.favorites,
    required this.recentOrders,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onToggleFavorite,
  });

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void _showUserProfileModal(BuildContext context, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle pill
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 18),

            // Profile Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade800, Colors.deepOrange.shade700],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 34, color: Colors.red.shade900),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'GOLD ★',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '+91 98765 43210 • alex@foodexpress.in',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Profile Action Tiles
            ListTile(
              leading: const Icon(Icons.account_balance_wallet_outlined, color: Colors.purple),
              title: const Text('Food Express Wallet (₹450)'),
              subtitle: const Text('Top up balance & view cashback'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const WalletScreen()),
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined, color: Colors.green),
              title: const Text('Active Live Orders'),
              subtitle: const Text('Live route tracking & driver contact'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const LiveOrdersScreen()),
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.location_on_outlined, color: Colors.orange),
              title: const Text('Saved Delivery Addresses'),
              subtitle: const Text('Home, Office, Other locations'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const SavedAddressesScreen()),
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.blue),
              title: const Text('App Settings & Preferences'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const SettingsScreen()),
                );
              },
            ),
            const Divider(height: 1),

            // Logout Button
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (c) => const LoginScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final greeting = getGreeting();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 15 : 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dynamic Header Banner
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '$greeting, $userName!',
                              style: TextStyle(
                                fontSize: isMobile ? 22 : 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            greeting == 'Good Morning'
                                ? Icons.wb_sunny_rounded
                                : greeting == 'Good Afternoon'
                                    ? Icons.wb_cloudy_rounded
                                    : Icons.nights_stay_rounded,
                            color: Colors.red.shade700,
                            size: isMobile ? 22 : 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'What would you like to eat today? 🛵',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (!isMobile)
                  InkWell(
                    onTap: () => _showUserProfileModal(context, userName),
                    borderRadius: BorderRadius.circular(24),
                    child: Tooltip(
                      message: 'Account Profile & Settings',
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red.shade300, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.red.shade100,
                          child: Icon(Icons.person, color: Colors.red.shade900, size: 24),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Dynamic Interactive Promotional Offers Carousel (Swiggy / Zomato Style)
            const PromoOffersCarousel(),

            const SizedBox(height: 25),

            // Popular Food Section
            const Text(
              'Popular Food',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            FoodGrid(
              isMobile: isMobile,
              isTablet: isTablet,
              cart: cart,
              favorites: favorites,
              onAddToCart: onAddToCart,
              onRemoveFromCart: onRemoveFromCart,
              onToggleFavorite: onToggleFavorite,
            ),

            const SizedBox(height: 30),

            // Recent Orders Section (Reflecting User's Actual Orders)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tap order for ticket details',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            RecentOrders(
              orders: recentOrders,
              onReorder: onAddToCart,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// PROMOTIONAL OFFERS CAROUSEL (Interactive Multi-Deal Cards)
// ======================================================
class PromoOffersCarousel extends StatelessWidget {
  const PromoOffersCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> offers = [
      {
        'tag': 'LIMITED TIME DEAL',
        'title': 'FLAT 50% OFF',
        'subtitle': 'Up to ₹120 on pizzas & combos',
        'code': 'FEAST50',
        'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&q=80',
        'gradient': [Colors.red.shade900, Colors.deepOrange.shade700],
      },
      {
        'tag': 'EXPRESS DELIVERY',
        'title': 'FREE DELIVERY',
        'subtitle': 'On gourmet burgers & meals above ₹199',
        'code': 'FREEDEL',
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
        'gradient': [const Color(0xFF1E3C72), const Color(0xFF2A5298)],
      },
      {
        'tag': 'HEALTHY BITES',
        'title': 'FLAT ₹75 CASHBACK',
        'subtitle': 'On organic salads & diet bowls',
        'code': 'HEALTHY75',
        'image': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&q=80',
        'gradient': [const Color(0xFF0F9B0F), const Color(0xFF00B074)],
      },
      {
        'tag': 'WALLET BONUS',
        'title': '10% WALLET BACK',
        'subtitle': 'Pay with Food Express Cash Wallet',
        'code': 'WALLET10',
        'image': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&q=80',
        'gradient': [const Color(0xFF7F00FF), const Color(0xFFE100FF)],
      },
    ];

    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Container(
            width: 320,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: offer['gradient'] as List<Color>,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: (offer['gradient'] as List<Color>).first.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Right-side angled dish photo
                Positioned(
                  right: -15,
                  bottom: -15,
                  top: -15,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(18)),
                    child: Opacity(
                      opacity: 0.35,
                      child: Image.network(
                        offer['image'] as String,
                        width: 140,
                        height: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tag Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          offer['tag'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer['title'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            offer['subtitle'] as String,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),

                      // Code Pill & Claim Button
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.confirmation_number_outlined,
                                    size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  offer['code'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '🎉 Coupon ${offer['code']} applied to your order!'),
                                  backgroundColor: Colors.green.shade800,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  color: (offer['gradient'] as List<Color>).first,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ======================================================
// ORDER DETAILS SCREEN (With Full Hero Photo & Go Back Button)
// ======================================================
class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String foodName;
  final String status;
  final String price;
  final String time;
  final String imageUrl;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.foodName,
    required this.status,
    required this.price,
    required this.time,
    this.imageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green;
    IconData statusIcon = Icons.check_circle;

    if (status == 'Preparing') {
      statusColor = Colors.orange;
      statusIcon = Icons.timer;
    } else if (status == 'Cancelled') {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order $orderId Details'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Icon(statusIcon, size: 60, color: statusColor),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      statusIcon,
                      size: 60,
                      color: statusColor,
                    ),
                  ),

                const SizedBox(height: 16),

                Text(
                  status,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          icon: Icons.receipt_long,
                          label: 'Order ID',
                          value: orderId,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          icon: Icons.fastfood,
                          label: 'Food Name',
                          value: foodName,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          icon: Icons.info_outline,
                          label: 'Status',
                          value: status,
                          valueColor: statusColor,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          icon: Icons.currency_rupee,
                          label: 'Total Amount',
                          value: price,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          icon: Icons.access_time,
                          label: 'Order Time',
                          value: time,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Go Back Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Go Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// ======================================================
// GENERIC DETAIL SCREEN (Fallback)
// ======================================================
class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 70, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// 1. SPECIAL DEALS SCREEN
// ======================================================
class SpecialDealsScreen extends StatelessWidget {
  const SpecialDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deals = [
      {
        'title': '50% OFF up to ₹120',
        'code': 'FEAST50',
        'desc': 'Valid on pizzas, burgers & party combos above ₹199',
        'color': Colors.red.shade700,
        'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&q=80',
      },
      {
        'title': 'FREE Delivery on Everything',
        'code': 'FREEDEL',
        'desc': 'No minimum order value required for Gold members',
        'color': Colors.blue.shade800,
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
      },
      {
        'title': 'Flat ₹100 Cashback',
        'code': 'CASH100',
        'desc': 'Pay using Food Express Wallet on orders above ₹399',
        'color': Colors.purple.shade700,
        'image': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&q=80',
      },
      {
        'title': 'Healthy Bites 30% OFF',
        'code': 'HEALTHY30',
        'desc': 'Valid on all organic salads, smoothie bowls & juices',
        'color': Colors.green.shade700,
        'image': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&q=80',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Deals & Coupons'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Exclusive Offers for You 🎉',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tap any coupon code to apply it directly to your cart',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),
                ...deals.map((deal) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          deal['image'] as String,
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            height: 130,
                            color: deal['color'] as Color,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    deal['title'] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: deal['color'] as Color,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                    ),
                                    child: Text(
                                      deal['code'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                deal['desc'] as String,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '🎉 Coupon ${deal['code']} Applied!'),
                                        backgroundColor: Colors.green.shade800,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: deal['color'] as Color,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Apply Coupon'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back to Dashboard'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 2. TOP RESTAURANTS SCREEN
// ======================================================
class TopRestaurantsScreen extends StatelessWidget {
  const TopRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants = [
      {
        'name': 'The Royal Biryani Co.',
        'cuisine': 'Hyderabadi • Mughlai • Kebabs',
        'rating': 4.9,
        'time': '20-25 mins',
        'distance': '1.4 km',
        'offer': '50% OFF up to ₹100',
        'image': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&q=80',
      },
      {
        'name': 'Napoli Woodfire Pizza & Pasta',
        'cuisine': 'Italian • Gourmet Pizza • Lasagna',
        'rating': 4.8,
        'time': '25-30 mins',
        'distance': '2.1 km',
        'offer': 'Free Garlic Bread on ₹299',
        'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&q=80',
      },
      {
        'name': 'Burger & Shake Express',
        'cuisine': 'American • Smash Burgers • Fries',
        'rating': 4.7,
        'time': '15-20 mins',
        'distance': '0.9 km',
        'offer': '₹40 OFF above ₹199',
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
      },
      {
        'name': 'Green Vitality Salads & Bowls',
        'cuisine': 'Healthy • Keto • Organic Juices',
        'rating': 4.9,
        'time': '15-20 mins',
        'distance': '1.2 km',
        'offer': 'Flat 20% OFF',
        'image': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&q=80',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Partner Restaurants'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Restaurants Near You 🏬',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                ...restaurants.map((rest) {
                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              rest['image'] as String,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star,
                                        size: 13, color: Colors.white),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${rest['rating']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rest['name'] as String,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                rest['cuisine'] as String,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.timer_outlined,
                                      size: 15, color: Colors.grey.shade600),
                                  const SizedBox(width: 4),
                                  Text(
                                    rest['time'] as String,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 14),
                                  Icon(Icons.location_on_outlined,
                                      size: 15, color: Colors.grey.shade600),
                                  const SizedBox(width: 4),
                                  Text(
                                    rest['distance'] as String,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 3. HEALTHY & DIET SCREEN
// ======================================================
class HealthyDietScreen extends StatelessWidget {
  const HealthyDietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final healthyItems = [
      {
        'name': 'Mediterranean Green Salad',
        'cal': '210 kcal',
        'price': '₹199',
        'tag': 'High Fiber • Vegan',
        'image': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&q=80',
      },
      {
        'name': 'Avocado & Quinoa Protein Bowl',
        'cal': '320 kcal',
        'price': '₹289',
        'tag': 'High Protein • Keto',
        'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80',
      },
      {
        'name': 'Grilled Paneer & Veggie Wrap',
        'cal': '280 kcal',
        'price': '₹229',
        'tag': 'Low Calorie • Fresh',
        'image': 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&q=80',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy & Diet Meals'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Clean Eating & Nutrition 🥗',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Fresh, low-calorie, nutrient-rich dishes cooked fresh',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),
                ...healthyItems.map((item) {
                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item['image'] as String,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item['tag']} • ${item['cal']}',
                                  style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['price'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 4. LIVE ORDERS SCREEN (Multi-Order Live Tracking & Details)
// ======================================================
class LiveOrdersScreen extends StatefulWidget {
  const LiveOrdersScreen({super.key});

  @override
  State<LiveOrdersScreen> createState() => _LiveOrdersScreenState();
}

class _LiveOrdersScreenState extends State<LiveOrdersScreen> {
  int _selectedOrderIndex = 0;

  final List<Map<String, dynamic>> _liveOrders = [
    {
      'id': '#1005',
      'restaurant': 'Burger & Shake Express',
      'items': [
        {'name': 'Classic Double Cheeseburger', 'qty': 1, 'price': '₹229'},
        {'name': 'Creamy Alfredo Pasta', 'qty': 1, 'price': '₹259'},
      ],
      'total': '₹488',
      'payment': 'Food Express Wallet',
      'address': 'Flat 402, Sunshine Heights, MG Road, Bengaluru',
      'eta': '14 mins',
      'status': 'Out for Delivery 🛵',
      'driverName': 'Rahul Sharma',
      'driverRating': '4.9 ★',
      'driverVehicle': 'TVS Ntorq • KA 01 EQ 4421',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
      'currentStep': 2, // 0: Confirmed, 1: Cooking, 2: Out for delivery, 3: Delivered
      'timeline': [
        {'title': 'Order Confirmed', 'time': '12:40 PM', 'isDone': true},
        {'title': 'Kitchen is Cooking 🍳', 'time': '12:45 PM', 'isDone': true},
        {'title': 'Rider Picked Up & On The Way 🛵', 'time': '12:54 PM', 'isDone': true, 'isActive': true},
        {'title': 'Delivered at Doorstep 🏠', 'time': 'Expected 01:08 PM', 'isDone': false},
      ],
    },
    {
      'id': '#1007',
      'restaurant': 'Napoli Woodfire Pizza',
      'items': [
        {'name': 'Extra Cheese Paneer Tandoori Pizza', 'qty': 1, 'price': '₹449'},
        {'name': 'Cheesy Garlic Breadsticks', 'qty': 1, 'price': '₹149'},
      ],
      'total': '₹598',
      'payment': 'Google Pay / UPI',
      'address': 'Flat 402, Sunshine Heights, MG Road, Bengaluru',
      'eta': '26 mins',
      'status': 'Kitchen is Cooking 🍳',
      'driverName': 'Vikram Singh',
      'driverRating': '4.8 ★',
      'driverVehicle': 'Honda Activa • KA 05 MB 8832',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80',
      'currentStep': 1,
      'timeline': [
        {'title': 'Order Confirmed', 'time': '01:10 PM', 'isDone': true},
        {'title': 'Chef is Baking Pizza in Woodfire Oven 🍕', 'time': '01:12 PM', 'isDone': true, 'isActive': true},
        {'title': 'Delivery Partner Assigned 🛵', 'time': 'Expected 01:25 PM', 'isDone': false},
        {'title': 'Delivered at Doorstep 🏠', 'time': 'Expected 01:38 PM', 'isDone': false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeOrder = _liveOrders[_selectedOrderIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Live Orders & Tracking'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Multi-Order Tab Selector
                Row(
                  children: [
                    const Text(
                      'ACTIVE ORDERS:',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_liveOrders.length} In Progress',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Order selection switcher pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_liveOrders.length, (idx) {
                      final ord = _liveOrders[idx];
                      final isSelected = _selectedOrderIndex == idx;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedOrderIndex = idx;
                            });
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.red.shade700 : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected ? Colors.red.shade700 : Colors.grey.shade300,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.red.withValues(alpha: 0.25),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      )
                                    ]
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  size: 20,
                                  color: isSelected ? Colors.white : Colors.red.shade700,
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order ${ord['id']}',
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      'ETA: ${ord['eta']}',
                                      style: TextStyle(
                                        color: isSelected ? Colors.white70 : Colors.grey.shade600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 18),

                // 1. Live ETA & Route Status Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade800, Colors.deepOrange.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.flash_on, size: 14, color: Colors.amberAccent),
                                const SizedBox(width: 4),
                                Text(
                                  activeOrder['status'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Order ${activeOrder['id']}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Arriving in ${activeOrder['eta']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'On time delivery to ${activeOrder['address']}',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 18),

                      // Interactive Live Delivery Route Strip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.storefront, color: Colors.white, size: 18),
                                SizedBox(width: 6),
                                Text('Kitchen',
                                    style: TextStyle(color: Colors.white, fontSize: 12)),
                              ],
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(color: Colors.white54, thickness: 2),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.delivery_dining,
                                  color: Colors.red, size: 18),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(color: Colors.white24, thickness: 2),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.home, color: Colors.white, size: 18),
                                SizedBox(width: 6),
                                Text('Home',
                                    style: TextStyle(color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // 2. Delivery Partner Card (With Call & Message buttons)
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.red.shade100,
                          child: const Icon(Icons.person, color: Colors.red, size: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    activeOrder['driverName'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      activeOrder['driverRating'] as String,
                                      style: TextStyle(
                                        color: Colors.green.shade800,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                activeOrder['driverVehicle'] as String,
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Calling ${activeOrder['driverName']}...'),
                                backgroundColor: Colors.green.shade800,
                              ),
                            );
                          },
                          icon: const Icon(Icons.phone, color: Colors.green),
                          tooltip: 'Call Driver',
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Opening chat with ${activeOrder['driverName']}...'),
                                backgroundColor: Colors.blue.shade800,
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat_bubble_outline, color: Colors.blue),
                          tooltip: 'Message Driver',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 3. The Order Itself (Items & Receipt Card)
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                activeOrder['image'] as String,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activeOrder['restaurant'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${(activeOrder['items'] as List).length} items ordered • Paid via ${activeOrder['payment']}',
                                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              activeOrder['total'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        const Text(
                          'ORDER BREAKDOWN:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...(activeOrder['items'] as List).map((it) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${it['qty']}x ${it['name']}',
                                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                                ),
                                Text(
                                  it['price'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 4. Live Progress Stepper Timeline
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Live Order Timeline',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        ...(activeOrder['timeline'] as List).asMap().entries.map((entry) {
                          final int idx = entry.key;
                          final step = entry.value as Map<String, dynamic>;
                          final isLast = idx == (activeOrder['timeline'] as List).length - 1;
                          final bool isDone = step['isDone'] ?? false;
                          final bool isActive = step['isActive'] ?? false;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isDone
                                        ? Icons.check_circle
                                        : (isActive ? Icons.radio_button_checked : Icons.radio_button_off),
                                    color: isDone
                                        ? Colors.green
                                        : (isActive ? Colors.orange : Colors.grey.shade400),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      step['title'] as String,
                                      style: TextStyle(
                                        fontWeight: isDone || isActive ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 13,
                                        color: isDone || isActive ? Colors.black87 : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    step['time'] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isActive ? Colors.orange.shade800 : Colors.grey,
                                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              if (!isLast)
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 22,
                                  width: 2,
                                  color: isDone ? Colors.green : Colors.grey.shade300,
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Go Back Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back to Dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 5. FAVORITES SCREEN
// ======================================================
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favItems = [
      {
        'name': 'Extra Cheese Paneer Tandoori Pizza',
        'price': '₹449',
        'rating': 4.9,
        'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80',
      },
      {
        'name': 'Special Dum Biryani',
        'price': '₹319',
        'rating': 4.9,
        'image': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&q=80',
      },
      {
        'name': 'Classic Double Cheeseburger',
        'price': '₹229',
        'rating': 4.8,
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Favorites ❤️'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Favorite Meals ❤️',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                ...favItems.map((item) {
                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image'] as String,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item['name'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${item['price']} • ⭐ ${item['rating']}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 6. FOOD WALLET SCREEN (Interactive Balance & Top-Up)
// ======================================================
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _balance = 450;
  final List<Map<String, String>> _transactions = [
    {
      'title': 'Wallet Cashback Received',
      'date': '28 Aug 2026',
      'amount': '+ ₹50.00',
      'isCredit': 'true',
    },
    {
      'title': 'Order #1006 Payment',
      'date': '27 Aug 2026',
      'amount': '- ₹379.00',
      'isCredit': 'false',
    },
  ];

  void _addMoney(int amt) {
    setState(() {
      _balance += amt;
      _transactions.insert(0, {
        'title': 'Wallet Top-Up (UPI/Card)',
        'date': 'Just now',
        'amount': '+ ₹$amt.00',
        'isCredit': 'true',
      });
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 ₹$amt added successfully! New Balance: ₹$_balance.00'),
        backgroundColor: Colors.green.shade800,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Express Wallet'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Balance Banner
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7F00FF).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '₹$_balance.00',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '• 10% Extra Cashback active on next top-up',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Quick Top-Up',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [100, 200, 500].map((amt) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () => _addMoney(amt),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade50,
                            foregroundColor: Colors.purple.shade900,
                            elevation: 0,
                            side: BorderSide(color: Colors.purple.shade200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '+ ₹$amt',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _transactions.length,
                    separatorBuilder: (c, i) => const Divider(height: 1),
                    itemBuilder: (c, i) {
                      final tx = _transactions[i];
                      final isCredit = tx['isCredit'] == 'true';
                      return ListTile(
                        leading: Icon(
                          isCredit ? Icons.add_circle : Icons.remove_circle,
                          color: isCredit ? Colors.green : Colors.red,
                        ),
                        title: Text(tx['title']!),
                        subtitle: Text(tx['date']!),
                        trailing: Text(
                          tx['amount']!,
                          style: TextStyle(
                            color: isCredit ? Colors.green : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 7. ORDER HISTORY SCREEN
// ======================================================
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {
        'id': '#1006',
        'food': 'Paneer Butter Masala + Roti',
        'price': '₹379',
        'date': 'Yesterday, 01:05 PM',
        'status': 'Delivered',
      },
      {
        'id': '#1005',
        'food': 'Burger + Pasta Combo',
        'price': '₹488',
        'date': '29 Aug 2026, 12:40 PM',
        'status': 'Delivered',
      },
      {
        'id': '#1003',
        'food': 'Extra Cheese Paneer Tandoori Pizza',
        'price': '₹449',
        'date': '26 Aug 2026, 08:15 PM',
        'status': 'Delivered',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Order History'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Past Orders & Invoices 📜',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                ...history.map((order) {
                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order ${order['id']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                order['status']!,
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(order['food']!,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order['date']!,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Text(
                                order['price']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 8. SAVED ADDRESSES SCREEN (Interactive Selection & Add Address)
// ======================================================
class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  int _selectedAddressIndex = 0;

  final List<Map<String, dynamic>> _addresses = [
    {
      'title': 'Home (Default)',
      'address': 'Flat 402, Sunshine Heights, MG Road, Bengaluru',
      'icon': Icons.home,
      'color': Colors.red,
    },
    {
      'title': 'Office',
      'address': 'Building 4B, EcoSpace Tech Park, Outer Ring Road',
      'icon': Icons.work,
      'color': Colors.blue,
    },
    {
      'title': "Parents' House",
      'address': '12/A, Palm Avenue, Indiranagar, Bengaluru',
      'icon': Icons.family_restroom,
      'color': Colors.orange,
    },
  ];

  void _showAddAddressDialog() {
    final titleController = TextEditingController();
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add Delivery Address 📍'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Address Label (e.g. Gym, Friend)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Full Address / Landmark',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && addressController.text.isNotEmpty) {
                setState(() {
                  _addresses.add({
                    'title': titleController.text.trim(),
                    'address': addressController.text.trim(),
                    'icon': Icons.location_on,
                    'color': Colors.green,
                  });
                  _selectedAddressIndex = _addresses.length - 1;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Address "${titleController.text}" added and selected!'),
                    backgroundColor: Colors.green.shade800,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save Address'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Delivery Addresses'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Delivery Location 📍',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                      onPressed: _showAddAddressDialog,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add New'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tap an address to set it as your active delivery destination',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 14),

                // Interactive Address Cards List
                ..._addresses.asMap().entries.map((entry) {
                  final int idx = entry.key;
                  final addr = entry.value;
                  final bool isSelected = _selectedAddressIndex == idx;

                  return Card(
                    elevation: isSelected ? 2 : 1,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isSelected ? Colors.green : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: (addr['color'] as Color).withValues(alpha: 0.15),
                        child: Icon(addr['icon'] as IconData, color: addr['color'] as Color),
                      ),
                      title: Text(
                        addr['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          addr['address'] as String,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      trailing: Icon(
                        isSelected ? Icons.check_circle : Icons.radio_button_off,
                        color: isSelected ? Colors.green : Colors.grey,
                        size: 24,
                      ),
                      onTap: () {
                        setState(() {
                          _selectedAddressIndex = idx;
                        });
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('📍 Delivery destination set to: ${addr['title']}'),
                            backgroundColor: Colors.green.shade800,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  );
                }),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 9. 24/7 LIVE SUPPORT SCREEN
// ======================================================
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('24/7 Customer Support'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How can we help you? 💬',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.location_searching, color: Colors.red),
                        title: const Text('Where is my order?'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => const LiveOrdersScreen()),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.cancel_outlined, color: Colors.orange),
                        title: const Text('Cancel or modify an order'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Orders within 60 seconds of placement can be modified via chat.'),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.currency_rupee, color: Colors.green),
                        title: const Text('Refund and payment queries'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Refunds are processed to Food Express Wallet in 2 hours.'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// 10. SETTINGS SCREEN (Interactive Switches)
// ======================================================
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _vegOnlyMode = false;
  bool _orderSms = true;
  bool _offersEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Preferences & Account ⚙️',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _pushNotifications,
                        onChanged: (val) {
                          setState(() {
                            _pushNotifications = val;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Push notifications ${val ? "Enabled" : "Disabled"}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        title: const Text('Push Notifications'),
                        subtitle: const Text('Get live order delivery updates'),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        value: _vegOnlyMode,
                        onChanged: (val) {
                          setState(() {
                            _vegOnlyMode = val;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Veg-Only Filter ${val ? "Activated" : "Deactivated"}'),
                              backgroundColor: val ? Colors.green : Colors.grey.shade800,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        title: const Text('Veg-Only Mode'),
                        subtitle: const Text('Only show 100% vegetarian dishes'),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        value: _orderSms,
                        onChanged: (val) {
                          setState(() {
                            _orderSms = val;
                          });
                        },
                        title: const Text('Order SMS Updates'),
                        subtitle: const Text('Receive delivery partner phone updates'),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        value: _offersEmail,
                        onChanged: (val) {
                          setState(() {
                            _offersEmail = val;
                          });
                        },
                        title: const Text('Promotional Emails'),
                        subtitle: const Text('Get weekend discount coupons'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// TASK: AI FOOD & RECOMMENDATIONS CHATBOT (User Assistant)
// ======================================================
class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class StatisticsChatbotSheet extends StatefulWidget {
  const StatisticsChatbotSheet({super.key});

  @override
  State<StatisticsChatbotSheet> createState() => _StatisticsChatbotSheetState();
}

class _StatisticsChatbotSheetState extends State<StatisticsChatbotSheet> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hello! 👋 I'm your Food Express AI Assistant.\n\nAsk me about top dish recommendations, deals, or delivery tracking!",
      isUser: false,
      time: "Just now",
    ),
  ];

  final List<String> _quickQuestions = [
    "🍕 Top Recommended Food",
    "⏳ Track My Order",
    "🥗 Healthy Meal Ideas",
    "🍔 Best Fast Food CombO",
    "⚡ Delivery Time Info",
  ];

  String _generateBotResponse(String userQuery) {
    final query = userQuery.toLowerCase().trim();

    if (query.contains("food") ||
        query.contains("popular") ||
        query.contains("best") ||
        query.contains("recommend") ||
        query.contains("pizza")) {
      return "🍕 **Top Recommended Dishes Today:**\n\n1. **Extra Cheese Paneer Tandoori Pizza** (₹449 - 4.9 ⭐)\n2. **Biryani** (₹319 - 4.9 ⭐)\n3. **Burger + Fries** (₹229 - 4.8 ⭐)\n4. **Pasta** (₹259 - 4.2 ⭐)";
    } else if (query.contains("track") ||
        query.contains("order") ||
        query.contains("pending") ||
        query.contains("preparing")) {
      return "⏳ **Active Orders in Preparation:**\n\n• **Order #1002** (Burger + Fries) is in the kitchen!\n• **Order #1005** (Burger + Pasta) is on prep.\n• Estimated delivery arrival in ~20 mins.";
    } else if (query.contains("healthy") ||
        query.contains("diet") ||
        query.contains("salad")) {
      return "🥗 **Healthy & Fresh Picks:**\n\n• **Fresh Garden Salad** (₹199 - 4.5 ⭐) — Packed with fresh greens & olive dressing.";
    } else if (query.contains("combo") ||
        query.contains("fast food") ||
        query.contains("burger")) {
      return "🍔 **Best Fast Food Combos:**\n\n• **Burger + Fries Combo** (₹289)\n• **Pizza + Coke Combo** (₹399)\n• **Pasta + Coke Combo** (₹319)";
    } else if (query.contains("time") ||
        query.contains("fast") ||
        query.contains("delivery")) {
      return "⚡ **Delivery Information:**\n\n• Average delivery speed is **20–25 minutes**.";
    } else {
      return "🤖 I can help you find meals!\n\nTry asking: *'What is the most popular food?'*, *'Track my order'*, or *'Healthy meal ideas'*!";
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text.trim(),
      isUser: true,
      time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
    );

    final botResponse = ChatMessage(
      text: _generateBotResponse(text),
      isUser: false,
      time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
    );

    setState(() {
      _messages.add(userMessage);
      _messages.add(botResponse);
    });

    _textController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.smart_toy_rounded,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Food Assistant',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Online • Recommendations & Tracking',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _quickQuestions.map((q) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(
                        q,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade900,
                        ),
                      ),
                      backgroundColor: Colors.red.shade50,
                      side: BorderSide(color: Colors.red.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onPressed: () => _sendMessage(q),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: msg.isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!msg.isUser)
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.red.shade100,
                          child: Icon(Icons.smart_toy_rounded,
                              size: 18, color: Colors.red.shade800),
                        ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? Colors.red.shade700
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
                              bottomRight: Radius.circular(msg.isUser ? 4 : 16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: msg.isUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.text,
                                style: TextStyle(
                                  color: msg.isUser
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 14,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg.time,
                                style: TextStyle(
                                  color: msg.isUser
                                      ? Colors.white70
                                      : Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (msg.isUser)
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.person,
                              size: 18, color: Colors.black87),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ask for recommendations, tracking...',
                        hintStyle: TextStyle(
                            fontSize: 13, color: Colors.grey.shade500),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.red.shade700,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded,
                          color: Colors.white, size: 20),
                      onPressed: () => _sendMessage(_textController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}