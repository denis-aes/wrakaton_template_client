// Copyright (c) 2016, Denis Obydennykh. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library TemplateClient.impl;

import 'dart:async';
import 'package:SemplexClientCmn/Utils/RestAdapter.dart';
import 'package:SemplexClientCmn/Utils/HttpCommunicator/HttpBrowserCommunicator.dart';

class TemplateClient {
  HttpCommunicator _netEngine = new HttpCommunicator();
  RestAdapter _rest;

  final String _baseUrl;

  TemplateClient([this._baseUrl]) {
      _rest = new RestAdapter(_netEngine);
  }

  String get ServerUrl => _baseUrl ?? '';

  Future SaveFormInfo(int wrikeFormId, Map data) async {
    return _rest.Create('${ServerUrl}/storage/forms', data);
  }

  Future<Map> GetFormInfo(int wrikeFormId)
    => _rest.Get('${ServerUrl}/storage/forms/${wrikeFormId}');

  Future SaveTaskInfo(int wrikeTaskId, int wrikeRootId, Map data) async {
    data['wroot_id'] = wrikeRootId;
    data['wid'] = wrikeTaskId;
    return _rest.Create('${ServerUrl}/storage/tasks', data);
  }

  Future<Map> GetTaskInfo(int wrikeTaskId)
    => _rest.Get('${ServerUrl}/storage/tasks/${wrikeTaskId}');

  Future<List> QueryByTaskData(String key, String value)
    => _rest.Get('${ServerUrl}/storage/tasks?${key}=${value}');

  Future<List> QueryByWrikeRootId(int wrootid)
      => _rest.Get('${ServerUrl}/storage/tasks?wroot_id=${wrootid}');

  Future<List> GetTemplates()
    => _rest.Get('${ServerUrl}/templates');

  Future<Map> GetTemplate(int id, [bool isFull = true])
    => _rest.Get('${ServerUrl}/templates/{$id}${isFull ? "?full" : ""}');

}
