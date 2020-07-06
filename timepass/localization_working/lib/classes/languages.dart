class Languages{
  final int id;
  final String name;
  final String langugeCode;

  Languages(this.id, this.name, this.langugeCode);

  static List<Languages> languagesList(){
    return <Languages>[
      Languages(1,'English','en'),
      Languages(2,'Hindi','hi'),
      Languages(3,'Marathi','mr'),
    ];
  }
}