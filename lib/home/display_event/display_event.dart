import 'package:event_finder_app/features/auth/presentation/widget/constants.dart';
import 'package:event_finder_app/home/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bay_ticket/PagePayer.dart';
import '../profile/profile_screen.dart';

// import './PagePayer.dart';
class DisplayEvent extends StatelessWidget {
  var height, width;

  final int id;
  final String title;
  final String imageUrl;
  final double prix;
  final String description;
  final String adress;
  final String duree;
  final String date;

  DisplayEvent(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.prix,
      required this.description,
      required this.adress,
      required this.duree,
      required this.date});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar('Event App'),
      drawer: const Drawer(
        backgroundColor: kPrimaryLightColor,
        child: ProfileScreen(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: height * 0.45,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.40),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                    ),
                    Align(
                      // alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: height * 0.25,
                        width: width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              description,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: width * 0.03,
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: kPrimaryColor,
                                  size: width * 0.07,
                                ),
                                Text(
                                  adress,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ],
                            ),
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              unratedColor: Colors.white,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          icon: const Icon(Icons.share, color: kPrimaryLightColor,size: 50,),
                          tooltip: "Share icon",
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 150,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.facebook),
                                          title: const Text('Facebook'),
                                          onTap: () {
                                            launch(
                                                'https://www.facebook.com/parta');
                                          },
                                        ),
                                        ListTile(
                                          leading:
                                              const Icon(Icons.facebook_rounded),

                                          title: const Text('Instagram'),
                                          onTap: () {
                                            launch('https://www.instagram.com/');
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.whatshot_sharp),
                                          title: const Text('WhatsApp'),
                                          onTap: () {
                                            launch('https://web.whatsapp.com/');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      size: height * 0.035,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      '$duree',
                      style: TextStyle(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: kPrimaryColor,
                      size: height * 0.035,
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.10,
              ),
              SizedBox(
                height: height * 0.08,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kPrimaryColor, width: 3),
                        color: const Color.fromARGB(255, 251, 252, 253),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_money_outlined,
                            size: height * 0.032,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "$prix",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 10, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PagePayer(
                              id: id,
                              title: title,
                              imageUrl: imageUrl,
                              prix: prix,
                              description: description,
                              adress: adress,
                              duree: duree,
                              date: date,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "get ticket",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
