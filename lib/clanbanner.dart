import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

class ClanBanner extends StatelessWidget {
  ClanBanner(
    this.name,
    this.tag,
    this.members,
    this.type,
    this.badgeUri,
    this.points,
  );

  late String tag;
  late String name;
  late String type;
  late int members;
  late Map badgeUri;
  late int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 175, 175, 175),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 65, 65, 65),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(badgeUri['small'].toString()),
          ),
          const SizedBox(
            height: 75,
            child: VerticalDivider(
              color: Color.fromARGB(255, 0, 0, 0),
              thickness: 2,
              indent: 5,
              endIndent: 0,
              width: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BorderedText(
                    strokeWidth: 2.0,
                    strokeColor: Colors.black,
                    child: Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          decorationColor: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  type.toLowerCase(),
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  "Tap to view details",
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // child: ListTile(
    //   title: Text('$name'),
    //   subtitle: Text('$tag'),
    //   trailing: Text("$members / 50"),
    //   leading: Image(image: NetworkImage(badgeUri['small'].toString())),
    // ),
  }
}
