import 'package:event_finder_app/home/components/home_header.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlatformView());
}

class PlatformView extends StatelessWidget {
  // static String routeName = "/home";
  const PlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 12, 12, 12).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Image(
                  image: AssetImage('assets/images/vue-map.jpg'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: HomeHeader(),
              ),
            ],
          ),
        ),
      
      ),
    );
  }
}
