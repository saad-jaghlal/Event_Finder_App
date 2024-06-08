import 'package:event_finder_app/home/display_event/display_event.dart';
import 'package:event_finder_app/home/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../features/auth/presentation/widget/constants.dart';
import 'components/app_bar.dart';
import 'components/item_widget.dart';
import 'model/event.dart';

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
  final _searchController = TextEditingController();
  String _searchedCity = 'Asfi';
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  final LatLng _center = const LatLng(31.79, -7.09);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Event> events = [
      Event(1, 'Event 1', 'Rabat', 'Description 1', 'https://images.unsplash.com/photo-1575728252059-db43d03fc2de?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTh8fG1vdW5hdGluc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=', 0, 'Adresse 1', 0, '2022-01-01',"12:30",120.0),
      Event(2, 'Event 1', 'Casablanca', 'Description 1', '', 0, 'Adresse 2', 0, '2022-01-01',"12:30",120.0),
      Event(3, 'Event 2', 'Rabat', 'Description 2', 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 3', 0, '2022-01-01',"12:30",120.0),
      Event(4, 'Event 1', 'Marrakech', 'Description 1','https://images.unsplash.com/photo-1493558103817-58b2924bce98?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTAxfHxiZWFjaHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 4', 0, '2022-01-01',"12:30",120.0),
      Event(5, 'Event 1', 'asfi', 'Description 1 Whereas disregard and contempt for human rights have resulted...', 'https://images.unsplash.com/photo-1575728252059-db43d03fc2de?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTh8fG1vdW5hdGluc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=', 0, 'Adresse 5', 0, '2022-01-01',"12:30",120.0),
      Event(6, 'Event 2', 'asfi', 'Description 2', 'https://images.unsplash.com/photo-1493558103817-58b2924bce98?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTAxfHxiZWFjaHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 6', 0, '2022-01-01',"12:30",120.0),
      Event(7, 'Event 3', 'asfi', 'Description 3', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 7', 0, '2022-01-01',"12:30",120.0),
      Event(8, 'Event 4', 'asfi', 'Description 4', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 8', 0, '2022-01-01',"12:30",120.0),
      Event(9, 'Event 5', 'asfi', 'Description 5', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 9', 0, '2022-01-01',"12:30",120.0),
      Event(10, 'Event 6', 'asfi', 'Description 6', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 10', 0, '2022-01-01',"12:30",120.0),
      Event(11, 'Event 7', 'asfi', 'Description 7', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 0, 'Adresse 11', 0, '2022-01-01',"12:30",120.0),
  ];
  List<Event> _filteredEvents = [];

  void onchangeCity(String city) {
    _searchedCity = city;
    print("Search icon pressed $_searchedCity");
    locationFromAddress(_searchedCity).then((locations) {
      if (locations.isNotEmpty) {
        final latLng = LatLng(locations[0].latitude, locations[0].longitude);
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 12)));
        setState(() {
          _markers.clear();
          _markers.add(Marker(
            markerId: MarkerId(_searchedCity),
            position: latLng,
          ));
          _filteredEvents = events
              .where((event) =>
                  event.location.trim().toLowerCase() ==
                  _searchedCity.trim().toLowerCase())
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar('Event App'),
      drawer: const Drawer(
        backgroundColor: kPrimaryLightColor,
        child: ProfileScreen(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 300, // Give a specific height to the map
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 70, 69, 69)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 9,
                            offset: const Offset(0, 2),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) async {
                          _onMapCreated(controller);
                          if (_searchedCity.isNotEmpty) {
                            onchangeCity(_searchedCity);
                          }
                        },
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 5.0,
                        ),
                        markers: _markers,
                      ),
                    ),
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Material(
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 14, 35, 224),
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          // onChanged: (value) {
                          //   setState(() {
                          //     _searchedCity = value;
                          //   });
                          //   onchangeCity(value);
                          // },
                          controller: _searchController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kSecondaryColor.withOpacity(0.1),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            border: searchOutlineInputBorder,
                            focusedBorder: searchOutlineInputBorder,
                            enabledBorder: searchOutlineInputBorder,
                            hintText: "Search City",
                            suffixIcon: AnimatedBuilder(
                              animation: _searchController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _searchController.text.isNotEmpty
                                      ? 2
                                      : 1.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: _searchController.text.isNotEmpty
                                          ? Colors.grey
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      print("Search icon pressed");
                                      if (_searchController.text.isNotEmpty) {
                                        onchangeCity(_searchController.text);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: ListView(
                children: _filteredEvents
                    .map((event) => ItemWidget(
                          name: event.title,
                          description: event.description,
                          image: event.imageUrl,
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "You tapped on ${event.title} ");
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content:Text('Yay! A SnackBar! You tapped on Item $index'),
                            //   action: SnackBarAction(
                            //     label: 'Undo',
                            //     onPressed: () {
                            //       // Some code to undo the change.
                            //     },
                            //   ),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DisplayEvent(
                                  id: event.id,
                                  title: event.title,
                                  imageUrl: event.imageUrl,
                                  prix: event.price,
                                  description: event.description,
                                  adress: event.address,
                                  duree: event.duree,
                                  date: event.date,
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);
