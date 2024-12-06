import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
import 'package:shoplocalclubcard/screens/screens.dart';
import 'package:shoplocalclubcard/utils/utils.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationProvider(),
        ),
      ],
      child: const ShopLocalClub(),
    ),
  );
}

class ShopLocalClub extends StatelessWidget {
  const ShopLocalClub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColors.primary,
      theme: getTheme(context),
      onGenerateRoute: onGenerateRoute,
      home: const SplashScreen(),
    );
  }

  ThemeData getTheme(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        foregroundColor: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          fixedSize: Size(
            size.width * 0.8,
            50,
          ),
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.grey,
        thickness: 1,
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(
          AppColors.primary,
        ),
        thumbColor: WidgetStatePropertyAll(
          AppColors.white,
        ),
      ),
      // iconTheme: const IconThemeData(color: AppColors.white),
    );
  }
}
