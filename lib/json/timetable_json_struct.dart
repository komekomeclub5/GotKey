class TimetableStruct {
  List<Timetable>? timetable;

  TimetableStruct({this.timetable});

  TimetableStruct.fromJson(Map<String, dynamic> json) {
    if (json['timetable'] != "none") {
      timetable = <Timetable>[];
      json['timetable'].forEach((v) {
        timetable!.add(Timetable.fromJson(v));
      });
    }
  }
}

class Timetable {
  String? gakubu;
  String? gakka;
  String? no;
  String? niti;
  String? gen;
  String? gakki;
  String? kurasu;
  String? kamoku;
  String? tantou;
  String? kyoushitsu;
  String? sou;
  String? ji;
  String? bikou;

  Timetable.fromJson(Map<String, dynamic> json) {
    gakubu = json['gakubu'];
    gakka = json['gakka'];
    no = json['No'];
    niti = json['niti'];
    gen = json['gen'];
    gakki = json['gakki'];
    kurasu = json['kurasu'];
    kamoku = json['kamoku'];
    tantou = json['tantou'];
    kyoushitsu = json['kyoushitsu'];
    sou = json['sou'];
    ji = json['ji'];
    bikou = json['bikou'];
  }
}
