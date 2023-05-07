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
    MaterialColor myAppColor = const MaterialColor(0xFF2C5AD2, <int, Color>{
      50: Color(0xFF2C5AD2),
      100: Color(0xFF2C5AD2),
      200: Color(0xFF2C5AD2),
      300: Color(0xFF2C5AD2),
      400: Color(0xFF2C5AD2),
      500: Color(0xFF2C5AD2),
      600: Color(0xFF2C5AD2),
      700: Color(0xFF2C5AD2),
      800: Color(0xFF2C5AD2),
      900: Color(0xFF2C5AD2),
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
