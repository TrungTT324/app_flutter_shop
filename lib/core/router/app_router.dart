import 'package:go_router/go_router.dart';
import '../../screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    // TODO: thêm route cho product_detail, cart, checkout, orders, profile, auth
  ],
);
