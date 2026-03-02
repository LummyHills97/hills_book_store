import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/create_account_screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/forgot_password_screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Logo with ColorFilter ---
              Center(
                child: ColorFiltered(
                  colorFilter: isDarkMode
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        ),
                  child: Image.asset(
                    "assets/images/onboarding/onboarding0.png",
                    height: 120,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- Title ---
              Text(
                "Welcome Back!",
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Login to your account to continue",
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),

              // --- Email Field ---
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),

              // --- Password Field ---
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // --- Forgot Password ---
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
              const SizedBox(height: 16),

              // --- Login Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MainNavigationScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(height: 24),

              // --- Divider ---
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Or sign in with",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // --- Social Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    onTap: () {},
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CustomPaint(painter: _GoogleLogoPainter()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _SocialButton(
                    onTap: () {},
                    child: Icon(
                      Icons.apple,
                      size: 22,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  _SocialButton(
                    onTap: () {},
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CustomPaint(
                        painter: _XLogoPainter(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // --- Sign Up Link ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: theme.textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
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

// ─── Reusable Social Button Shell ────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _SocialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 56,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.12 : 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

// ─── Proper Google "G" Logo Painter ──────────────────────────────────────────

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Offset center = Offset(w / 2, h / 2);
    final double outerR = w / 2;
    final double innerR = outerR * 0.62;

    final paint = Paint()..style = PaintingStyle.fill;

    const double deg = math.pi / 180;

    // Helper: draw a filled donut segment
    void drawSegment(Color color, double startDeg, double sweepDeg) {
      final double startRad = startDeg * deg;
      final double sweepRad = sweepDeg * deg;

      paint.color = color;
      final path = Path();

      // Move to outer arc start
      path.moveTo(
        center.dx + outerR * math.cos(startRad),
        center.dy + outerR * math.sin(startRad),
      );
      // Outer arc
      path.arcTo(
        Rect.fromCircle(center: center, radius: outerR),
        startRad,
        sweepRad,
        false,
      );
      // Line in to inner arc end
      path.lineTo(
        center.dx + innerR * math.cos(startRad + sweepRad),
        center.dy + innerR * math.sin(startRad + sweepRad),
      );
      // Inner arc (reverse)
      path.arcTo(
        Rect.fromCircle(center: center, radius: innerR),
        startRad + sweepRad,
        -sweepRad,
        false,
      );
      path.close();
      canvas.drawPath(path, paint);
    }

    // Red: top-right arc (~-10° to 90°)
    drawSegment(const Color(0xFFEA4335), -10, 100);
    // Yellow: bottom-right (~90° to 180°)
    drawSegment(const Color(0xFFFBBC05), 90, 90);
    // Green: bottom-left (~180° to 270°)
    drawSegment(const Color(0xFF34A853), 180, 90);
    // Blue: left + top (~270° to 350°), leaves gap for the G cutout
    drawSegment(const Color(0xFF4285F4), 270, 80);

    // Blue horizontal bar (the G shelf) — drawn as a filled rect
    // covering from center-x to right edge, vertically ~13% of radius tall
    final double barHalfH = outerR * 0.135;
    paint.color = const Color(0xFF4285F4);
    canvas.drawRect(
      Rect.fromLTRB(
        center.dx - outerR * 0.01, // tiny overlap to avoid gap
        center.dy - barHalfH,
        center.dx + outerR,
        center.dy + barHalfH,
      ),
      paint,
    );

    // White inner circle to create the ring effect
    paint.color = Colors.white;
    canvas.drawCircle(center, innerR, paint);

    // Re-draw the bar clipped to the ring area so it appears inside the G
    paint.color = const Color(0xFF4285F4);
    canvas.drawRect(
      Rect.fromLTRB(
        center.dx,
        center.dy - barHalfH,
        center.dx + innerR,
        center.dy + barHalfH,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── X Logo Painter ──────────────────────────────────────────────────────────

class _XLogoPainter extends CustomPainter {
  final Color color;
  const _XLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.13
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double pad = size.width * 0.05;
    canvas.drawLine(
      Offset(pad, pad),
      Offset(size.width - pad, size.height - pad),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - pad, pad),
      Offset(pad, size.height - pad),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _XLogoPainter old) => old.color != color;
}