#### `Data Contracts`
Represents the structure of the data being sent and received from the server to the client, and vice-versa. Derives from the class `DataContractBase`, and `JsonDataContract` for JSON data.

##### Creating a data contract class

Given the following JSON schema:

```json
{
    "id": 1,
    "name": "Todo Name",
    "description": "Todo Description"
}
```

We can create a data contract class. You can also use this [site](https://app.quicktype.io/) to generate classes from JSON. Below is a modified version of the generated class:

```dart
class TodoContract extends JsonDataContract {
  TodoContract({this.id, this.name, this.description});

  final String description;
  final int id;
  final String name;

  factory TodoContract.fromJson(Map<String, Object> json) {
    return TodoContract(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
```
- Inherits from `JsonDataContract`, meaning that this data contract can be serialized to JSON by calling the method `toJson()`.
- Serialization is done by calling `TodoDataContract.toJson()`.
- Deserialization is done by calling the factory `TodoDataContract.fromJson()`.

#### `Web Services`

Web services contains the calls to API endpoints. Derives from the class `WebServiceBase`.

##### Consuming an API endpoint

Say that we have this endpoint `http://www.todo.com/todos` and requires a `GET` request to retrieve a list of to-dos. 

The endpoint will return a JSON response:

```json
{
  "items": [
    {
      "id": 1,
      "name": "Todo Name",
      "description": "Todo Description"
    },
    {
      "id": 2,
      "name": "Todo Name",
      "description": "Todo Description"
    }
  ]
}
```

First, we'll make a base data contract class `ListResponse<T>` where `T` is any class inheriting from `JsonDataContract`:

```dart
abstract class ListContract<T extends JsonDataContract> extends JsonDataContract {
  ListContract({this.items = const []});

  List<T> items;

  @override
  Map<String, dynamic> toJson() {
    return {
      'items': List<dynamic>.from(items.map((x) => x.toJson())),
    };
  }
}
```
- This class can be inherited by any data contract class has the same JSON schema as above.

Next, we create the data contract class for the type `T`, which is `TodoContract`. This class will be inheriting from `JsonDataContract`:

```dart
class TodoContract extends JsonDataContract {
  TodoContract({this.id, this.name, this.description});

  final int id;
  final String name;
  final String description;

  factory TodoContract.fromJson(Map<String, dynamic> json) {
    return TodoContract(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
```

Then we create the class inheriting from `ListResponse<T>` called `TodoListResponse`:

```dart
class TodoListContract extends ListContract<TodoContract> {
  TodoListContract({List<TodoContract> items}) : super(items: items);

  factory TodoListContract.fromJson(Map<String, dynamic> json) {
    return TodoListContract(
      items: List<TodoContract>.from(json['items'].map((x) => TodoContract.fromJson(x))),
    );
  }
}
```

For our web service class, we create `TodoWebService` and define a method `getTodos()` for getting the list of to-dos.


```dart
class TodoWebService extends WebServiceBase {
  TodoWebService(HttpHandler httpHandler) : super(httpHandler);

  Future<List<TodoContract>> getTodos() async {
    var response = await get('todos', decoder: (json) => TodoListResponse.fromJson(json));
    return response.items;
  }
}
```
- `WebServiceBase` has various methods for HTTP requests.
- We call the `get` method inherited from `WebServiceBase`, and we only pass `'todos'` as the `endpoint` because the server address is automatically appended when sending requests. To configure the server address, see `AppConfiguration`.
- The `decoder` is used to transform the decoded JSON response to another type, which is `TodoListContract`. We will use the `TodoListContract.fromJson()` factory method.

##### Error handling

`HttpHandler` handles all HTTP requests from `WebServiceBase`. The `HttpHandler.send()` contains all the logic for error handling.

`HttpHandler.send()` throws the following exceptions:

- `ApiException` - This is thrown when the response's status code is other than `200 OK`.
- `ServerException` - A more specific type of `ApiException`. This is thrown when the response's status code is a server error `500 Internal Server Error`.
- `TimeoutException` - Thrown when the request timed-out. The current timeout duration is `30 seconds`.