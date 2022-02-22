import 'dart:math';

import 'package:clashofclans_viewer/clan_detail.dart';
import 'package:clashofclans_viewer/clanbanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

final List<Clan> clans = [];
bool visiblity = false;
List<dynamic> jsonData = [
  // Clan(
  //   badgeUri: {},
  //   members: 0,
  //   name: '',
  //   tag: '',
  //   type: '',
  // )
];
void main() => runApp(const ClashViewer());

class ClashViewer extends StatefulWidget {
  const ClashViewer({Key? key}) : super(key: key);

  @override
  _ClashViewerState createState() => _ClashViewerState();
}

class _ClashViewerState extends State<ClashViewer> {
  Future getData(String clan) async {
    http.Response response;
    clans.clear();
    try {
      response = await http.get(
          Uri.parse("https://api.clashofclans.com/v1/clans?name=$clan"),
          headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjI1NzQ4ZTNkLTg3OWMtNDM5Ni04Y2RhLTM1ZmQxNjFmZDU2OCIsImlhdCI6MTY0NTUwNTIyNywic3ViIjoiZGV2ZWxvcGVyLzgyYzFiNTlkLTIzOGYtMzQ5Zi05YjdiLTRmZjgxMWRiYjE3NyIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjguMzQuNjkuMTUzIl0sInR5cGUiOiJjbGllbnQifV19.gxdht5D0PO4TvcCHSV-24oknSwLgHRmTYYWOl-vaGkQ0OAovySH-xax1zGNNSianwgSikxFDqucr6KCvlFZMDQ'
          });
      jsonData = jsonDecode(response.body)['items'];
      for (int i = 0; i < jsonData.length; i++) {
        Clan clan = Clan(
            tag: jsonData[i]['tag'],
            members: jsonData[i]['members'],
            name: jsonData[i]['name'],
            type: jsonData[i]['type'],
            badgeUri: jsonData[i]['badgeUrls'],
            points: jsonData[i]['clanPoints']);
        clans.add(clan);
        setState(() {
          visiblity = false;
        });
      }
    } catch (e) {
      setState(() {
        visiblity = true;
      });
    }
  }

  TextEditingController clan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: TextField(
                    controller: clan,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  child: Text("No Data Loaded"),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visiblity,
                ),
                ElevatedButton(
                  onPressed: () {
                    getData(clan.text.trim());
                  },
                  child: Text("Get Data"),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                    children: clans.map((cs) {
                  return ClanBanner(
                    cs.name,
                    cs.tag,
                    cs.members,
                    cs.type,
                    cs.badgeUri,
                    cs.points,
                  );
                }).toList())
              ],
            )
          ],
        ),
      ),
    );
  }
}
