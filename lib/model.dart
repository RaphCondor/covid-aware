class Album{
  final List<Results> results;

  Album({this.results});

  factory Album.fromJson(Map<String, dynamic> json){
    var list = json['results'] as List;
    List<Results> featuresList = list.map((i) => Results.fromJson(i)).toList();

  return Album(
    results: featuresList
  );
}
}

class Results {
  int data;
  int deaths;
  int recovered;

  Results({this.data,this.deaths,this.recovered});
  
factory Results.fromJson(Map<String, dynamic> json){
 return Results(
   data: json['total_cases'],
   deaths: json['total_deaths'],
   recovered: json['total_recovered']
 );
}
}
   
class Album1{
  final List<CountryItems> results;

  Album1({this.results});

  factory Album1.fromJson(Map<String, dynamic> json){
    var list = json['countryitems'] as List;
    List<CountryItems> featuresList = list.map((i) => CountryItems.fromJson(i)).toList();

  return Album1(
    results: featuresList
  );
  }
}

class CountryItems {
    Data data;

    CountryItems({this.data});
    
  factory CountryItems.fromJson(Map<String, dynamic> json){
  return CountryItems(
    data: Data.fromJson(json['124']),
  );
  }
}

class Data{
  String tc;
  String td;
  String tr;
  String nc;
  String nd;

  Data({this.tc,this.td,this.tr, this.nc, this.nd});

  factory Data.fromJson(Map<String, dynamic> json){
    return new Data(
      tc: json['total_cases'].toString(),
      td: json['total_deaths'].toString(),
      tr: json['total_recovered'].toString(),
      nc: json['total_new_cases_today'].toString(),
      nd: json['total_new_deaths_today'].toString(),
    
    );
  }

}