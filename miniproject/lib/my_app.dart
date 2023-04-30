import 'package:flutter/material.dart';
import 'package:miniproject/View/Pages/Customer/change_customer_page.dart';
import 'package:miniproject/View/Pages/Customer/create_customer_page.dart';
import 'package:miniproject/View/Pages/Customer/customers_list_page.dart';
import 'package:miniproject/View/Pages/Dashboard/dashboard_page.dart';
import 'package:miniproject/View/Pages/Debt/add_debt_page.dart';
import 'package:miniproject/View/Pages/Debt/debt_details_page.dart';
import 'package:miniproject/View/View-Model/customer_view_model.dart';
import 'package:miniproject/View/View-Model/dashboard_view_model.dart';
import 'package:miniproject/View/View-Model/debt_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor myAppColor = const MaterialColor(0xFF6D67E4, <int, Color>{
      50: Color(0xFF6D67E4),
      100: Color(0xFF6D67E4),
      200: Color(0xFF6D67E4),
      300: Color(0xFF6D67E4),
      400: Color(0xFF6D67E4),
      500: Color(0xFF6D67E4),
      600: Color(0xFF6D67E4),
      700: Color(0xFF6D67E4),
      800: Color(0xFF6D67E4),
      900: Color(0xFF6D67E4),
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DebtViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: myAppColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: {
          '/': (context) => const DashboardPage(),
          CreateCustomerPage.routeName: (context) => const CreateCustomerPage(),
          CustomersListPage.routeName: (context) => const CustomersListPage(),
          ChangeCustomerPage.routeName: (context) => const ChangeCustomerPage(),
          DebtDetailsPage.routeName: (context) => const DebtDetailsPage(),
          AddDebtPage.routeName: (context) => const AddDebtPage(),
        },
      ),
    );
  }
}
