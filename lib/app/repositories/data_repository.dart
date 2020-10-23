import 'package:coronavirus_app/app/repositories/endpoint_data.dart';
import 'package:coronavirus_app/app/services/api.dart';
import 'package:coronavirus_app/app/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;

  String _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async =>
    await _getDataRefreshToken<int>(
      onGetData: () => apiService.getEndpointData(
        accessToken: _accessToken, endpoint: endpoint)
    );

   Future<EndpointData> getAllEndpointData() async => 
    await _getDataRefreshToken<EndpointData>(
      onGetData: _getAllEndpointData,
    );

  Future<T> _getDataRefreshToken<T>({Future<T> Function() onGetData}) async {
    try {
   
      if (_accessToken == null ) {
        _accessToken = await apiService.getAccessToken();
      }

        return await onGetData();
      } on Response catch (response) {
        print('response server $response');
        if (response.statusCode == 401) {
          _accessToken = await apiService.getAccessToken();
          return await onGetData();
        }
        
        rethrow;
      } 
    }

  Future<EndpointData> _getAllEndpointData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.caseConfirmed),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);

    return EndpointData(
    values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.caseConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }

}