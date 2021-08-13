import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/repositories/data_repository.dart';
import 'package:quizz/repositories/endpoints_data.dart';
import 'package:quizz/services/api.dart';
import 'package:quizz/ui/endpoint_card.dart';
import 'package:quizz/ui/last_update_status.dart';
import 'package:quizz/ui/show_alert_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCacheData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository = Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      await showAlertDialog(
        context: context, 
        title: 'Connection Error', 
        content: 'Could not retrieve data. Please try again later', 
        defaultActionText: 'OK'
      );
    } catch (_) {
      await showAlertDialog(
        context: context, 
        title: 'Unknown Error', 
        content: 'Could not retrieve data. Please try again later', 
        defaultActionText: 'OK'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData.values[Endpoint.cases]?.date
            : null);
    return Scaffold(
        appBar: AppBar(
          title: Text('Coronovirus tracker'),
        ),
        body: RefreshIndicator(
          onRefresh: _updateData,
          child: ListView(
            children: <Widget>[
              LastUpdateStatus(text: formatter.lastUpdatedStatusText()),
              for (var endpoint in Endpoint.values)
                EndpointCard(
                  endpoint: endpoint,
                  value: _endpointsData != null
                      ? _endpointsData.values[endpoint]?.value
                      : null,
                )
            ],
          ),
        ));
  }
}
