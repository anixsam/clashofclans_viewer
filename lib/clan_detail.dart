import 'package:clashofclans_viewer/badgeUrl.dart';

class Clan {
  late String tag;
  late String name;
  late String type;
  late int members;
  late int points;
  late Map<String, dynamic> badgeUri;

  Clan(
      {required this.tag,
      required this.name,
      required this.members,
      required this.type,
      required this.points,
      required this.badgeUri});
}
