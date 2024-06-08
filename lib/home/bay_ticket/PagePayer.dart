import 'package:event_finder_app/features/auth/presentation/widget/constants.dart';
import 'package:event_finder_app/home/components/app_bar.dart';
import 'package:event_finder_app/home/get_ticket/qr_code_page.dart';
import 'package:event_finder_app/home/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'afficher.dart'; // Importez le fichier afficher.dart ou le nom de votre fichier de la prochaine page

class PagePayer extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final double prix;
  final String description;
  final String adress;
  final String duree;
  final String date;

  const PagePayer({
    super.key, 
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.prix,
    required this.description,
    required this.adress,
    required this.duree,
    required this.date,
  });

  @override
  
  // ignore: library_private_types_in_public_api
  _PagePayerState createState() => _PagePayerState();
}

class _PagePayerState extends State<PagePayer> {
  final _formKey = GlobalKey<FormState>(); // Clé globale pour le formulaire

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  // Méthode de validation du formulaire
  bool _validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // ignore: unused_element
  void _onItemTapped(int index) {
    setState(() {});
    // Handle navigation based on the selected index
    // Example: if (index == 0) Navigator.push(...);
  }

  @override
  Widget build(BuildContext context) {
    return MenuHome(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(widget.title ,style: const  TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Total à payer:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.prix} \$',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.paypal),
                        iconSize: 45,
                        color: Color.fromARGB(255, 23, 104, 224),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => PaypalCheckout(
                              sandboxMode: true,
                              clientId:
                                  "AQxiUkh9Gqok_a_4RLMSjbxaQTLQRIQaylw7mk-zHSaNyTOjX_HrhYGW_jb4bptCGzw4tjDr5lfqZQpF",
                              secretKey:
                                  "EP_xBoZeLuUhBSDzIPuFronp_1Twe0CjxCXh2NpPGPUH2TslopgiEtUTQXxlZoWQPX-mf8leQG4vh7BB",
                              returnURL: "success.snippetcoder.com",
                              cancelURL: "cancel.snippetcoder.com",
                              transactions: const [
                                {
                                  "amount": {
                                    "total": '70',
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": '70',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "Apple",
                                        "quantity": 4,
                                        "price": '5',
                                        "currency": "USD"
                                      },
                                      {
                                        "name": "Pineapple",
                                        "quantity": 5,
                                        "price": '10',
                                        "currency": "USD"
                                      }
                                    ],

                                    // shipping address is not required though
                                    //   "shipping_address": {
                                    //     "recipient_name": "Raman Singh",
                                    //     "line1": "Delhi",
                                    //     "line2": "",
                                    //     "city": "Delhi",
                                    //     "country_code": "IN",
                                    //     "postal_code": "11001",
                                    //     "phone": "+00000000",
                                    //     "state": "Texas"
                                    //  },
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                // ignore: avoid_print
                                print("onSuccess: $params");
                              },
                              onError: (error) {
                                // ignore: avoid_print
                                print("onError: $error");
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                // ignore: avoid_print
                                print('cancelled:');
                              },
                            ),
                          ),
                          );
                        },
                      )
                    ]),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom complet',
                    hintText: "01/30",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom complet';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de carte',
                  hintText: "4545 5456 **** **** ",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le numéro de carte';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryDateController,
                        decoration: const InputDecoration(
                          labelText: 'Date d\'expiration',
                          hintText: "01/30",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer la date d\'expiration';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          hintText: "144",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le CVV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Validation du formulaire avant de naviguer vers la prochaine page
                      if (_validateForm()) {
                        // Navigation vers la prochaine page (Afficher) en passant les données à afficher
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrCodePage(
                              // Passer les données à afficher
                              cardNumber: _cardNumberController.text,
                              expiryDate: _expiryDateController.text,
                              cvv: _cvvController.text,
                              fullName: _fullNameController.text,
                              id: widget.id,
                              title: widget.title,
                              imageUrl:widget.imageUrl,
                              prix:widget.prix,
                              description:widget.description,
                              adress:widget.adress,
                              duree:widget.duree,
                              date: widget.date,
                            ),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        kPrimaryColor,
                      ),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        'Payer',
                        style: TextStyle(fontSize: 20,color: kPrimaryLightColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuHome extends StatelessWidget {
  final Widget body;

  MenuHome({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: MyAppBar('Event App'),
      drawer: const Drawer(
        backgroundColor: kPrimaryLightColor,
        child: ProfileScreen(),
      ),

      body: body,
    );
  }
}
