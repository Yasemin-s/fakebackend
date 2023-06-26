// class LoadData{
//   final String gun;
//   final String sabah;
//   final String ogle;
//   final String araogun;
//   final String aksam;

//   LoadData({required this.gun, required this.sabah,required this.ogle,required this.araogun,required this.aksam});

// /*
//   factory LoadData.fromJson(Map<String, dynamic> json){
//     return LoadData(
//       gun: json["gun"] ?? "null kismi gun",
//       sabah: json["sabah"] ?? "null kismi sabah",
//       ogle: json["ogle"] ?? "null kismi ogle",
//       araogun: json["araogun"] ?? "null kismi araogun",
//       aksam: json["aksam"] ?? "null kismi aksam"
//       );
//   }
// */
// factory LoadData.fromJson(Map<String, dynamic> json) {
//   if (json == null) {
//     throw Exception("Geçersiz JSON verisi"); // JSON null ise hata fırlat
//   }

//   if (!json.containsKey("gun") ||
//       !json.containsKey("sabah") ||
//       !json.containsKey("ogle") ||
//       !json.containsKey("araogun") ||
//       !json.containsKey("aksam")) {
//     throw Exception("Eksik veya hatalı alanlar"); // Gerekli alanlar eksik veya hatalı ise hata fırlat
//   }

//   return LoadData(
//     gun: json["gun"] as String,
//     sabah: json["sabah"] as String,
//     ogle: json["ogle"] as String,
//     araogun: json["araogun"] as String,
//     aksam: json["aksam"] as String,
//   );
// }
// }

class LoadData {
  final List<Program> program1;
  final List<Program> program2;
  final List<Program> program3;

  LoadData({
    required this.program1,
    required this.program2,
    required this.program3,
  });

  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
      program1: parseProgramList(json['program1']),
      program2: parseProgramList(json['program2']),
      program3: parseProgramList(json['program3']),
    );
  }

  static List<Program> parseProgramList(dynamic json) {
    if (json is List) {
      return json.map((item) => Program.fromJson(item)).toList();
    } else {
      throw Exception("Program listesi dönüştürülürken hata oluştu");
    }
  }
}

class Program {
  final String gun;
  final String sabah;
  final String ogle;
  final String araogun;
  final String aksam;

  Program({
    required this.gun,
    required this.sabah,
    required this.ogle,
    required this.araogun,
    required this.aksam,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      gun: json['gun'] as String,
      sabah: json['sabah'] as String,
      ogle: json['ogle'] as String,
      araogun: json['araogun'] as String,
      aksam: json['aksam'] as String,
    );
  }
}
