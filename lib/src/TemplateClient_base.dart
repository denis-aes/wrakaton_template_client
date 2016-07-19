// Copyright (c) 2016, Denis Obydennykh. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:SemplexClientCmn/Utils/HttpCommunicator/HttpBrowserCommunicator.dart';
import 'package:SemplexClientCmn/Utils/RestAdapter.dart';
import 'dart:async';


class TemplateClient {
  HttpCommunicator http;
  RestAdapter net;
  String serverUrl;

  TemplateClient(this.serverUrl){
    http = new HttpCommunicator();
    net = new RestAdapter(http);
  }

  Future getFormById(int formId) async {
    Map resp = await net.Get("$serverUrl/forms/$formId");
    return resp;
  }

  Future setTemplateById(int templateId, Map data) async {

  }

  Future getTemplateById(int templateId) async {
    Map resp = await net.Get("$serverUrl/templates/$templateId");
    return resp;
  }

  Future getTaskById(int taskId) async {

  }

  Future getTaskBySubtaskId(int subtaskId) async {

  }

  Future storeTask(int taskId, Map data) async{

  }
}
