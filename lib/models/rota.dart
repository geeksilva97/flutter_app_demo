class Rota {
  String codRoe;
  String desRoe;

  Rota({
    this.codRoe,
    this.desRoe
  });

  factory Rota.fromJson(Map<String, dynamic> json) =>  Rota(
    codRoe: json['codRoe'],
    desRoe: json['desRoe']
  );

  Map<String, dynamic> toJson() => {
    "codRoe": codRoe == null ? null : codRoe,
    "desRoe": desRoe == null ? null : desRoe,
  };
}