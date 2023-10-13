# Agenda

App para consulta e criação de Ceps

# Configurações
Para rodar o projeto é necessário ter conta na Back4App e criar um App com as seguintes colunas:
```json
{
  "Name": "",
  "PhoneNumber": "",
  "ImagePath": "",
  "email": ""
}
```
Obs: os campos "Name" e "PhoneNumber" são obrigatórios.

Renomeie o arquivo ".env.example" na raiz do projeto para ".env" e substitua as aspas pelas suas chaves do Back4App:
```env
BACK4APP_PARSE_APPLICATION_ID=""
BACK4APP_PARSE_REST_API_KEY=""
```
No arquivo "lib/repositories/agenda_repository.dart " coloque o caminho correspondente do seu app na variável url:

```dart
var url = "/Agenda";
```
