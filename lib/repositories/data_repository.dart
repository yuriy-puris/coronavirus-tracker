import 'package:quizz/services/api.dart';
import 'package:quizz/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';


class DataRepository extends ChangeNotifier {
  DataRepository({@required this.apiService});
  final APIService apiService;

  String _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndpointData(accessToken: _accessToken, endpoint: endpoint);
    } on Response catch(response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(accessToken: _accessToken, endpoint: endpoint);
      }
      rethrow;
    }
  }
}