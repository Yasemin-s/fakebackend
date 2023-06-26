class LoadData{
  final String gun;
  final String sabah;
  final String ogle;
  final String araogun;
  final String aksam;

  LoadData({required this.gun, required this.sabah,required this.ogle,required this.araogun,required this.aksam});

  factory LoadData.fromJson(Map<String, dynamic> json){
    return LoadData(
      gun: json["gun"],
      sabah: json["sabah"],
      ogle: json["ogle"],
      araogun: json["araogun"],
      aksam: json["aksam"]
      );
  }

}