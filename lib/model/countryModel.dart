class CountryModel{

  String id;
  String sortName;
  String countryName;
  String phoneCode;

  CountryModel({this.countryName,this.id,this.phoneCode,this.sortName});

}

class StateModel{

  String id;
  String stateName;
  String countryId;

  StateModel({this.id,this.countryId,this.stateName});

}