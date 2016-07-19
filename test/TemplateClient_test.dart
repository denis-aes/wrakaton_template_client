// Copyright (c) 2016, Denis Obydennykh. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:wrakaton_template_client/TemplateClient.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    TemplateClient client = new TemplateClient('http://46.252.162.118:8001');

    setUp(() {
      //awesome = new Awesome();
    });

    test('First Test', () async {
      var resp = await client.GetTaskWorkflow(1);
      print(resp);
    });
  });
}
