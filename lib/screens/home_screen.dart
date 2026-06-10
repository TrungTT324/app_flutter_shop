import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/product.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _bottomNavIndex = 0;
  int _cartCount = 0;

  List<Product> get _displayedProducts =>
      getProductsByCategory(categories[_selectedCategoryIndex].id);

  void _addToCart() {
    setState(() => _cartCount++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Đã thêm vào giỏ hàng'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(child: BannerSlider(items: banners)),
            SliverToBoxAdapter(child: _buildCategoryFilter()),
            SliverToBoxAdapter(child: _buildFlashSaleSection()),
            SliverToBoxAdapter(child: _buildNewArrivalsSection()),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Tất cả sản phẩm',
                actionLabel: 'Xem thêm',
                onAction: () {},
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => ProductCard(
                    product: _displayedProducts[i],
                    onTap: _addToCart,
                  ),
                  childCount: _displayedProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      floating: true,
      pinned: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFFE53935)),
                    const SizedBox(width: 2),
                    Text(
                      'Hà Nội, VN',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF888888)),
                  ],
                ),
                const Text(
                  'Fashion Store',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF1A1A1A)),
                  onPressed: () {},
                ),
                if (_cartCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$_cartCount',
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Color(0xFF1A1A1A)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search_rounded, color: Color(0xFF888888), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Danh mục', onAction: null),
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (_, i) {
              final selected = _selectedCategoryIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategoryIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF1A1A1A) : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: selected
                        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 3))]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        categories[i].icon,
                        size: 14,
                        color: selected ? Colors.white : Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        categories[i].name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlashSaleSection() {
    final saleProducts = flashSaleProducts;
    if (saleProducts.isEmpty) return const SizedBox();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            children: [
              const Icon(Icons.local_fire_department_rounded, color: Color(0xFFE53935), size: 22),
              const SizedBox(width: 6),
              const Text(
                'Flash Sale',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
              ),
              const SizedBox(width: 12),
              _CountdownTimer(),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text('Xem thêm', style: TextStyle(fontSize: 13, color: Color(0xFF888888))),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: saleProducts.length,
            itemBuilder: (_, i) => SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ProductCard(product: saleProducts[i], onTap: _addToCart),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewArrivalsSection() {
    final newProducts = newArrivalProducts;
    if (newProducts.isEmpty) return const SizedBox();

    return Column(
      children: [
        SectionHeader(title: 'Hàng mới về', actionLabel: 'Xem thêm', onAction: () {}),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: newProducts.length,
            itemBuilder: (_, i) => SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ProductCard(product: newProducts[i], onTap: _addToCart),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    final items = [
      (Icons.home_rounded, Icons.home_outlined, 'Trang chủ'),
      (Icons.search_rounded, Icons.search_outlined, 'Tìm kiếm'),
      (Icons.favorite_rounded, Icons.favorite_border_rounded, 'Yêu thích'),
      (Icons.shopping_bag_rounded, Icons.shopping_bag_outlined, 'Giỏ hàng'),
      (Icons.person_rounded, Icons.person_outline_rounded, 'Cá nhân'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = _bottomNavIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _bottomNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF1A1A1A).withValues(alpha: 0.08) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected ? items[i].$1 : items[i].$2,
                        color: selected ? const Color(0xFF1A1A1A) : Colors.grey[400],
                        size: 24,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[i].$3,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected ? const Color(0xFF1A1A1A) : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _CountdownTimer extends StatefulWidget {
  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  int _seconds = 3600 * 5 + 23 * 60 + 47;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _tick);
  }

  void _tick() {
    if (!mounted) return;
    setState(() => _seconds = _seconds > 0 ? _seconds - 1 : 0);
    if (_seconds > 0) Future.delayed(const Duration(seconds: 1), _tick);
  }

  @override
  Widget build(BuildContext context) {
    final h = _seconds ~/ 3600;
    final m = (_seconds % 3600) ~/ 60;
    final s = _seconds % 60;
    return Row(
      children: [
        _TimeBox(h.toString().padLeft(2, '0')),
        const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE53935))),
        _TimeBox(m.toString().padLeft(2, '0')),
        const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE53935))),
        _TimeBox(s.toString().padLeft(2, '0')),
      ],
    );
  }
}

class _TimeBox extends StatelessWidget {
  final String value;
  const _TimeBox(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
