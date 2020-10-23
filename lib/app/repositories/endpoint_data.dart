import 'package:coronavirus_app/app/services/api.dart';
import 'package:flutter/cupertino.dart';

class EndpointData {
  EndpointData({@required this.values});
  final Map<Endpoint, int> values;

  int get cases => values[Endpoint.cases];
  int get casesSuspected => values[Endpoint.casesSuspected];
  int get caseConfirmed => values[Endpoint.caseConfirmed];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];

  @override 
  String toString() => 
  'cases: $cases, suspected: $casesSuspected, caseConfirmed: $caseConfirmed, deaths: $deaths, recovered: $recovered';
}