import 'package:ecommerceriverpod/src/features/authentication/data/authRepository.dart';
import 'package:ecommerceriverpod/src/features/authentication/data/auth_provider.dart';
import 'package:ecommerceriverpod/src/features/authentication/domain/enum%20AuthState%20%7B%20loading,%20authenticated,%20notAuthenticated.dart';
import 'package:ecommerceriverpod/src/features/authentication/presentation/sign_in/login_screen.dart';
import 'package:ecommerceriverpod/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart.dart';
import 'package:ecommerceriverpod/src/sharedLayout.dart';
import 'package:ecommerceriverpod/src/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'src/features/authentication/presentation/signup_screen.dart';
import 'src/features/products/presentation/products_list/product_grid.dart';
import 'dart:developer' as devtools show log;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Constants.settingsStorageKey); // settings
  await Hive.openBox(Constants.authStorageKey); // auth

  runApp(ProviderScope(child: MyApp()));
  // await dotenv.load(fileName: '.env');
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = GoRouter(
      redirect: (context, state) async {
        if (state.location == '/register') return '/register';
        devtools.log("state");
        print(state.location == '/register');
        final authStatus =
            ref.watch(authNotifierProvider.select((value) => value.status));
        devtools.log("authStatus");
        devtools.log(authStatus.toString());
        if (authStatus == AuthState.notAuthenticated) {
          return '/login';
        }
        return null;
      },
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SharedLayout();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        // GoRoute(
        //   path: '/product/:id',
        //   name: 'product',
        //   builder: (context, state) => DetailsView(id: state.params['id']!),
        // ),
        // GoRoute(
        //   path: '/homepage',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const SharedLayout();
        //   },
        // ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUp();
          },
        ),
        // GoRoute(
        //   path: '/search',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const SearchView();
        //   },
        // ),
        // GoRoute(
        //   path: '/cart',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return CartPage();
        //   },
        // ),
      ],
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String userId;
    // return LoginScreen();
    // final state1 = ref.watch();
    return LoginScreen();
    // final state = ref.read(emailPasswordSignInControllerProvider);
    // return state.when(
    //     data: (state) {
    //       return state == AuthState.authenticated
    //           ? const SharedLayout()
    //           : const LoginScreen();
    //     },
    //     error: (error, stackTrace) => const Scaffold(
    //           body: LoginScreen(),
    //         ),
    //     loading: () => const Scaffold(
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         ));
    //         ));
    // final user = FirebaseAuth.instance.currentUser;

    // userId=user!.uid.toString();
    // Provider.of<Cart>(context).cartUser(user!.uid.toString());
    // return FutureBuilder(
    //   future: Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform,
    //   ),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         if (user != null) {
    //           if (user.emailVerified) {
    //             return const HomePage();
    //           } else {
    //             return const Login();
    //           }
    //         } else {
    //           return const Login();
    //         }
    //       default:
    //         return const CircularProgressIndicator();
    //     }
    //   },
    // );
  }
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
