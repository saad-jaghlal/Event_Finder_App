import 'package:event_finder_app/features/auth/presentation/widget/constants.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.onTap,
  });
  final String image;
  final String name;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kPrimaryColor,
        shadowColor: Colors.black,
        margin: const EdgeInsets.fromLTRB(4, 2, 4, 10),
        elevation: 7,
        child: SizedBox(
          // height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  image,
                  height: 100,
                  // width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(name, style: const TextStyle(fontFamily: 'Schyler', color: kPrimaryLightColor)),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Schyler', color: kPrimaryLightColor)
                    ),
                    const Text(
                      "Click here to descover more",
                      style: TextStyle(
                        fontFamily: 'Schyler',
                        color: Color.fromARGB(255, 0, 1, 2),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromARGB(255, 0, 0, 0),
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
