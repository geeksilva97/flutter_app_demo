class Transacao {
  int codEmp;
  String codTns;
  String desTns;
  String  lisMod;

  Transacao({
    this.codEmp,
    this.codTns,
    this.desTns,
    this.lisMod
  });

  factory Transacao.fromJson(Map<String, dynamic> json) => Transacao(
    codEmp: json['codEmp'],
    codTns: json['codTns'],
    desTns: json['desTns'],
    lisMod: json['lisMod']
  );
}