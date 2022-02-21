import 'package:clashofclans_viewer/clan_detail.dart';
import 'package:clashofclans_viewer/clanbanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

final List<Clan> clans = [];
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
    response = await http.get(
        Uri.parse("https://api.clashofclans.com/v1/clans?name=$clan"),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjkzYzNmYWQ4LWI0MmUtNGZkMi1iZjA3LTc2MTdlZjM0MzRlNSIsImlhdCI6MTY0NTQ3MjI3NSwic3ViIjoiZGV2ZWxvcGVyLzgyYzFiNTlkLTIzOGYtMzQ5Zi05YjdiLTRmZjgxMWRiYjE3NyIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjguMjguODIuNjQiXSwidHlwZSI6ImNsaWVudCJ9XX0.qG0yhKva_ovlWfFogfr2G2NFQR8MmfkxqD1CfIcepFTjqYAABJIkjcXL7Uo3O94Z6uId5scKfIOQGfM02Lj1gQ'
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
      print(jsonData[4]);
      setState(() {});
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
