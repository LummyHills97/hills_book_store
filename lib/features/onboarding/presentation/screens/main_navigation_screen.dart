import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/home_screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/explore_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/library_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/profile_page.dart';
import 'dart:math' as math;

// Change this to switch styles: 'bubble', 'liquid', or 'particle'
const String BOTTOM_NAV_STYLE = 'liquid';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ExplorePage(),
    const LibraryPage(),
    const ProfilePage(),
  ];

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    NavItem(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore_rounded,
      label: 'Explore',
    ),
    NavItem(
      icon: Icons.library_books_outlined,
      activeIcon: Icons.library_books_rounded,
      label: 'Library',
    ),
    NavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    switch (BOTTOM_NAV_STYLE) {
      case 'bubble':
        return BubbleMorphBottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: (index) => setState(() => _currentIndex = index),
        );
      case 'particle':
        return ParticleBurstBottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: (index) => setState(() => _currentIndex = index),
        );
      case 'liquid':
      default:
        return LiquidSwipeBottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: (index) => setState(() => _currentIndex = index),
        );
    }
  }
}

// ==================== STYLE 1: LIQUID SWIPE ====================
class LiquidSwipeBottomNav extends StatefulWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(int) onTap;

  const LiquidSwipeBottomNav({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  State<LiquidSwipeBottomNav> createState() => _LiquidSwipeBottomNavState();
}

class _LiquidSwipeBottomNavState extends State<LiquidSwipeBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  double _targetPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _positionAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(LiquidSwipeBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToPosition(widget.currentIndex);
    }
  }

  void _animateToPosition(int index) {
    setState(() {
      _targetPosition = index.toDouble();
      _positionAnimation = Tween<double>(
        begin: _positionAnimation.value,
        end: _targetPosition,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final itemWidth = (width - 32) / widget.items.length;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      height: 75,
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.5)
                : theme.colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Liquid blob background
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return Positioned(
                left: _positionAnimation.value * itemWidth + 8,
                top: 8,
                child: Container(
                  width: itemWidth - 16,
                  height: 59,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Items
          Row(
            children: List.generate(
              widget.items.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: _buildLiquidItem(
                    widget.items[index],
                    index,
                    theme,
                    isDark,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiquidItem(NavItem item, int index, ThemeData theme, bool isDark) {
    final isActive = widget.currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: isActive ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Icon(
              isActive ? item.activeIcon : item.icon,
              size: 26,
              color: isActive
                  ? Colors.white
                  : isDark
                      ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6)
                      : theme.textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: isActive ? 12 : 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? Colors.white
                  : isDark
                      ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6)
                      : theme.textTheme.bodyMedium?.color,
              fontFamily: 'Poppins',
            ),
            child: Text(item.label),
          ),
        ],
      ),
    );
  }
}

// ==================== STYLE 2: BUBBLE MORPH ====================
class BubbleMorphBottomNav extends StatefulWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(int) onTap;

  const BubbleMorphBottomNav({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  State<BubbleMorphBottomNav> createState() => _BubbleMorphBottomNavState();
}

class _BubbleMorphBottomNavState extends State<BubbleMorphBottomNav>
    with TickerProviderStateMixin {
  late AnimationController _morphController;
  late AnimationController _pulseController;
  late Animation<double> _morphAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _morphController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _morphAnimation = CurvedAnimation(
      parent: _morphController,
      curve: Curves.elasticOut,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(BubbleMorphBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _morphController.forward(from: 0);
      _pulseController.repeat(reverse: true);
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) _pulseController.stop();
      });
    }
  }

  @override
  void dispose() {
    _morphController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.5)
                : theme.colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.items.length,
          (index) => _buildBubbleItem(
            widget.items[index],
            index,
            theme,
            isDark,
          ),
        ),
      ),
    );
  }

  Widget _buildBubbleItem(NavItem item, int index, ThemeData theme, bool isDark) {
    final isActive = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedBuilder(
        animation: Listenable.merge([_morphAnimation, _pulseAnimation]),
        builder: (context, child) {
          final scale = isActive
              ? (widget.currentIndex == index ? _pulseAnimation.value : 1.0)
              : 1.0;

          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 110 : 55,
              height: 55,
              decoration: BoxDecoration(
                gradient: isActive
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(30),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isActive ? item.activeIcon : item.icon,
                    size: 24,
                    color: isActive
                        ? Colors.white
                        : isDark
                            ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6)
                            : theme.textTheme.bodyMedium?.color,
                  ),
                  if (isActive) ...[
                    const SizedBox(width: 8),
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==================== STYLE 3: PARTICLE BURST ====================
class ParticleBurstBottomNav extends StatefulWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(int) onTap;

  const ParticleBurstBottomNav({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  State<ParticleBurstBottomNav> createState() => _ParticleBurstBottomNavState();
}

class _ParticleBurstBottomNavState extends State<ParticleBurstBottomNav>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _rotationController;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(ParticleBurstBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _createParticles();
      _particleController.forward(from: 0);
      _rotationController.forward(from: 0);
    }
  }

  void _createParticles() {
    _particles.clear();
    for (int i = 0; i < 12; i++) {
      _particles.add(Particle(
        angle: (i * 30.0) * (math.pi / 180),
        speed: 2.0 + (i % 3),
      ));
    }
    setState(() {});
  }

  @override
  void dispose() {
    _particleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.5)
                : theme.colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.items.length,
          (index) => _buildParticleItem(
            widget.items[index],
            index,
            theme,
            isDark,
          ),
        ),
      ),
    );
  }

  Widget _buildParticleItem(NavItem item, int index, ThemeData theme, bool isDark) {
    final isActive = widget.currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 65,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none, // Changed from Clip.none to allow some overflow but controlled
            children: [
              // Particle effects
              if (isActive)
                ...List.generate(
                  _particles.length,
                  (i) => AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, child) {
                      final particle = _particles[i];
                      final progress = _particleController.value;
                      final distance = progress * particle.speed * 15; // Reduced from 20 to 15
                      
                      return Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Transform.translate(
                          offset: Offset(
                            math.cos(particle.angle) * distance,
                            math.sin(particle.angle) * distance,
                          ),
                          child: Center(
                            child: Opacity(
                              opacity: 1 - progress,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.6),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // Main icon
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: isActive && widget.currentIndex == index
                            ? _rotationController.value * 2 * math.pi
                            : 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.all(isActive ? 12 : 8),
                          decoration: BoxDecoration(
                            gradient: isActive
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      theme.colorScheme.primary,
                                      theme.colorScheme.secondary,
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            isActive ? item.activeIcon : item.icon,
                            size: 24,
                            color: isActive
                                ? Colors.white
                                : isDark
                                    ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6)
                                    : theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: isActive ? 12 : 10,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive
                          ? theme.colorScheme.primary
                          : isDark
                              ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6)
                              : theme.textTheme.bodyMedium?.color,
                      fontFamily: 'Poppins',
                    ),
                    child: Text(item.label),
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

class Particle {
  final double angle;
  final double speed;

  Particle({required this.angle, required this.speed});
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}