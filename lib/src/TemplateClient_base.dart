// Copyright (c) 2016, Denis Obydennykh. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:SemplexClientCmn/Utils/HttpCommunicator/HttpBrowserCommunicator.dart';
import 'package:SemplexClientCmn/Utils/RestAdapter.dart';
import 'dart:async';


class TemplateClient {
  HttpCommunicator http;
  RestAdapter net;
  String _srvUrl;

  TemplateClient(this._srvUrl){
    http = new HttpCommunicator();
    net = new RestAdapter(http);
  }

  Future getFormById(int formId) async {

  }

  Future setTemplateById(int templateId, Map data) async {

  }

  Future getTemplateById(int templateId) async {

  }

  Future getTaskById(int taskId) async {

  }

  Future getTaskBySubtaskId(int subtaskId) async {

  }

  Future storeTask(int taskId, Map data) async{

  }
}
