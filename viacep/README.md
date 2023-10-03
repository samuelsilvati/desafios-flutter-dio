# Consultar Cep

App para consulta e criação de Ceps

# Configurações
Para rodar o projeto é necessário ter conta na Back4App e criar um App com as seguintes colunas:
```json
{
    "cep": "",
    "logradouro": "",
    "complemento": "",
    "bairro": "",
    "localidade": "",
    "uf": ""
}
```
No arquivo lib/repositories/cep_back4app_repository,dart substitua as aspas pelas suas chaves do Back4App:
```dart
CepBack4AppRepository() {
    _dio.options.headers["X-Parse-Application-Id"] = "";
    _dio.options.headers["X-Parse-REST-API-Key"] = "";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes";
  }
```
Coloque o caminho correspondente do seu app na variável url:

```dart
var url = "/cep";
```
