// Copyright (c) 2016, Denis Obydennykh. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library TemplateClient.impl;

import 'dart:async';
import 'package:SemplexClientCmn/Utils/RestAdapter.dart';
import 'package:SemplexClientCmn/Utils/HttpCommunicator/HttpBrowserCommunicator.dart';
import 'package:SemplexClientCmn/Utils/Interfaces/ICommunicator.dart';
import 'dart:convert';

class TemplateClient {
  ICommunicator _netEngine = new HttpCommunicator();
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
                      int tmpl_sub,
                      String tmpl_root_ref_name,
                      String tmpl_sub_ref_name
                    ) async {
    Map data = {
      'wroot_id' : wrikeRootId,
      'wid' : wrikeTaskId,
      'tmpl_root' : tmpl_root,
      'tmpl_sub' : tmpl_sub,
      'tmpl_root_ref_name': tmpl_root_ref_name,
      'tmpl_sub_ref_name': tmpl_sub_ref_name
    };
    return _rest.Create('${ServerUrl}/storage/tasks', {
      'id' : wrikeTaskId,
      'data' : data
    });
  }

  Future SaveTaskInfoBulk(List<Map<String, dynamic>> dataList) async {
    var result;
    await Future.forEach(dataList, (data) async {
      int wrikeTaskId = data == null ? null : data["wid"];
      if (wrikeTaskId != null) {
        result = _rest.Create('${ServerUrl}/storage/tasks', {
          'id' : wrikeTaskId,
          'data' : data
        });
      }
    });

    return result;
  }

  Future<List<Map>> GetTasks()
  => _rest.Get('${ServerUrl}/storage/tasks');

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

  Future<List> GetTemplates([bool isFull = false])
    => _rest.Get('${ServerUrl}/templates${isFull ? "?full" : ""}');

  Future<List> GetProjectTemplates()
      => _rest.Get('${ServerUrl}/templates/projects?full');

  Future<List> GetFoldersTemplates()
      => _rest.Get('${ServerUrl}/templates/projects?full');

  Future<Map> GetTemplate(int id, [bool isFull = true])
    => _rest.Get('${ServerUrl}/templates/${id}${isFull ? "?full" : ""}');

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
