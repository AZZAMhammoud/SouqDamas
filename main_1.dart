import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/seller_dashboard_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'services/auth_service.dart';
import 'services/cart_service.dart';
import 'services/product_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/category/:categoryId',
        builder: (context, state) => CategoryScreen(
          categoryId: state.pathParameters['categoryId']!,
        ),
      ),
      GoRoute(
        path: '/product/:productId',
        builder: (context, state) => ProductDetailScreen(
          productId: state.pathParameters['productId']!,
        ),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/seller-dashboard',
        builder: (context, state) => const SellerDashboardScreen(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CartService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
      ],
      child: MaterialApp.router(
        title: 'سوقلي - Soqaly',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: const Color(0xFF00695C),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00695C),
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.notoKufiArabicTextTheme(
            Theme.of(context).textTheme.copyWith(
              displayLarge: GoogleFonts.reemKufi(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00695C),
              ),
              displayMedium: GoogleFonts.reemKufi(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF004D40),
              ),
              displaySmall: GoogleFonts.reemKufi(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF00695C),
              ),
              headlineLarge: GoogleFonts.notoKufiArabic(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF263238),
              ),
              headlineMedium: GoogleFonts.notoKufiArabic(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF37474F),
              ),
              headlineSmall: GoogleFonts.notoKufiArabic(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF455A64),
              ),
              titleLarge: GoogleFonts.notoKufiArabic(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF263238),
              ),
              titleMedium: GoogleFonts.notoKufiArabic(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF37474F),
              ),
              titleSmall: GoogleFonts.notoKufiArabic(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF546E7A),
              ),
              bodyLarge: GoogleFonts.notoKufiArabic(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF212121),
              ),
              bodyMedium: GoogleFonts.notoKufiArabic(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF424242),
              ),
              bodySmall: GoogleFonts.notoKufiArabic(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF616161),
              ),
              labelLarge: GoogleFonts.notoKufiArabic(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF00695C),
              ),
              labelMedium: GoogleFonts.notoKufiArabic(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF00796B),
              ),
              labelSmall: GoogleFonts.notoKufiArabic(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF00897B),
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF00695C),
            foregroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: GoogleFonts.reemKufi(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              textStyle: GoogleFonts.notoKufiArabic(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.all(8),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00695C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00695C), width: 2),
            ),
            labelStyle: GoogleFonts.notoKufiArabic(
              color: const Color(0xFF00695C),
              fontWeight: FontWeight.w500,
            ),
            hintStyle: GoogleFonts.notoKufiArabic(
              color: const Color(0xFF757575),
            ),
          ),
        ),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar', 'SA'),
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}

