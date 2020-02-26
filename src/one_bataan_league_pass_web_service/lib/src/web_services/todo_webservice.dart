import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/http_handler.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/web_service_base.dart';

class TodoWebService extends WebServiceBase {
  TodoWebService(HttpHandler httpHandler) : super(httpHandler);

  Future<void> createTodo(TodoDataContract newTodo) => post(ApiConstants.createTodo, parameter: newTodo);

  Future<void> deleteTodo(int id) => delete(ApiConstants.deleteTodo(id));
}
