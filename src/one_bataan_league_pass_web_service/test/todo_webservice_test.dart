import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_web_service/src/data_contracts/todo_data_contract.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/http_method.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/todo_webservice.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'mocks/web_service_mocks.dart';

void main() {
  group(TodoWebService, () {
    MockHttpHandler mockHttpHandler;
    TodoWebService unit;

    setUp(() {
      mockHttpHandler = MockHttpHandler();
      unit = TodoWebService(mockHttpHandler);
    });

    test('Verify To-Do is created if successful request', () async {
      // Arrange
      when(mockHttpHandler.send(ApiConstants.createTodo, HttpMethod.post, any, any))
          .thenAnswer((_) => Future.value(Response("success", 200)));

      // Act
      await unit.createTodo(TodoDataContract());

      // Assert
      verify(mockHttpHandler.send(ApiConstants.createTodo, HttpMethod.post, any, any)).called(1);
    });
  });
}
