// Copyright (c) 2016, Denis Obydennykh. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library TemplateClient.impl;

import 'dart:async';
import 'package:SemplexClientCmn/Utils/RestAdapter.dart';
import 'package:SemplexClientCmn/Utils/HttpCommunicator/HttpBrowserCommunicator.dart';
import 'dart:convert';

class TemplateClient {
  HttpCommunicator _netEngine = new HttpCommunicator();
  RestAdapter _rest;

  final String _baseUrl;

  TemplateClient([this._baseUrl]) {
      _rest = new RestAdapter(_netEngine);
  }

  String get ServerUrl => _baseUrl ?? '';

  Future SaveFormInfo(int wrikeFormId, Map data) async {
    return _rest.Create('${ServerUrl}/storage/forms', {
      'id' : wrikeFormId,
      'data' : data
    });
  }

  Future<List> GetForms() => _rest.Get('${ServerUrl}/storage/forms');

  Future<Map> GetFormInfo(int wrikeFormId)
    => _rest.Get('${ServerUrl}/storage/forms/${wrikeFormId}');

  Future SaveTaskInfo(int wrikeTaskId,
                      int wrikeRootId,
                      int tmpl_root,
                      int tmpl_sub) async {
    Map data = {
      'wroot_id' : wrikeRootId,
      'wid' : wrikeTaskId,
      'tmpl_root' : tmpl_root,
      'tmpl_sub' : tmpl_sub
    };
    return _rest.Create('${ServerUrl}/storage/tasks', {
      'id' : wrikeTaskId,
      'data' : data
    });
  }

  Future<Map> GetTaskInfo(int wrikeTaskId)
    => _rest.Get('${ServerUrl}/storage/tasks/${wrikeTaskId}');

  Future<List> GetTaskWorkflow(int wrikeTaskId) {
    return GetTaskInfo(wrikeTaskId).then((Map el){
      return GetTemplate(el['tmpl_sub'], false)
      .then((Map el) => el['data']['workflow']);
    });
  }

  Future<List> QueryByTaskData(String key, String value)
    => _rest.Get('${ServerUrl}/storage/tasks?${key}=${value}');

  Future<List> QueryByWrikeRootId(int wrootid)
      => _rest.Get('${ServerUrl}/storage/tasks?wroot_id=${wrootid}');

  Future<List> GetTemplates()
    => _rest.Get('${ServerUrl}/templates');

  Future<List> GetProjectTemplates()
      => _rest.Get('${ServerUrl}/templates/projects?full');

  Future<Map> GetTemplate(int id, [bool isFull = true])
    => _rest.Get('${ServerUrl}/templates/{$id}${isFull ? "?full" : ""}');

  Future<Map> GetTemplateByRef(String refName, [bool isFull = true])
    => _rest.Get('${ServerUrl}/templates/ref/{$refName}${isFull ? "?full" : ""}');

  Future CreateTemplate(String header,
                        String description,
                        String type, /*TASK | PROJECT*/
                        List<String> assignee,
                        List workflow)
  {
    Map template = {
      'title' : header,
      'description' : description,
      'type' : type,
      'assignee' : JSON.encode(assignee),
      'workflow' : JSON.encode(workflow)
    };
    return _rest.Create("${ServerUrl}/templates", template);
  }

}
