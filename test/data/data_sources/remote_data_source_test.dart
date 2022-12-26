import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Response;
import 'package:mockito/mockito.dart';
import 'package:prueba_ceiba/src/core/errors/exceptions.dart';
import 'package:prueba_ceiba/src/core/network/client_service.dart';
import 'package:prueba_ceiba/src/data/datasources/remote_data_source.dart';
import 'package:prueba_ceiba/src/data/models/post_model.dart';
import 'package:prueba_ceiba/src/data/models/user_model.dart';

class MockClientService extends Mock implements ClientService {
  @override
  Future<Response> get(String? url) => super.noSuchMethod(
        Invocation.method(#get, [url]),
        returnValue: Future.value(Response('', 200)),
        returnValueForMissingStub: Future.value(Response('', 404)),
      ) as Future<Response>;
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockClientService mockClient;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  await dotenv.load(fileName: 'assets/env/.env.test');

  setUp(() {
    mockClient = MockClientService();
    remoteDataSourceImpl = RemoteDataSourceImpl(client: mockClient);
  });

  group('getUserList', () {
    test('should return a list of Users', () async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => Response(
          '''[
            {
              "id": 1,
              "name": "Leanne Graham",
              "username": "Bret",
              "email": "Sincere@april.biz",
              "address": {
                "street": "Kulas Light",
                "suite": "Apt. 556",
                "city": "Gwenborough",
                "zipcode": "92998-3874",
                "geo": {
                  "lat": "-37.3159",
                  "lng": "81.1496"
                }
              },
              "phone": "1-770-736-8031 x56442",
              "website": "hildegard.org",
              "company": {
                "name": "Romaguera-Crona",
                "catchPhrase": "Multi-layered client-server neural-net",
                "bs": "harness real-time e-markets"
              }
            }
          ]''',
          200,
        ),
      );

      final result = await remoteDataSourceImpl.getUserList();

      expect(result, isA<List<UserModel>>());
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      when(mockClient.get(any)).thenAnswer((_) async => Response('', 404));

      final call = remoteDataSourceImpl.getUserList;

      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getPostList', () {
    test('should return a list of Posts', () async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => Response(
          '''[
            {
              "userId": 1,
              "id": 1,
              "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
              "body": "Dignissim sadipscing sanctus zzril euismod sed euismod gubergren illum stet clita elit nostrud soluta eos tempor. Sit laoreet commodo sanctus amet eum lorem vero est iusto diam voluptua accumsan clita ut lorem. Et wisi ea elitr ea at sit voluptua sanctus dolore eirmod at no ea."
            }
          ]''',
          200,
        ),
      );

      final result = await remoteDataSourceImpl.getPostList(1);

      expect(result, isA<List<PostModel>>());
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      when(mockClient.get(any)).thenAnswer((_) async => Response('', 404));

      final call = remoteDataSourceImpl.getPostList;

      expect(() => call(1), throwsA(isA<ServerException>()));
    });
  });
}
