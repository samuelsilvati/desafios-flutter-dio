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
Renomeie o arquivo ".env.example" na raiz do projeto para ".env" e substitua as aspas pelas suas chaves do Back4App:
```env
BACK4APP_PARSE_APPLICATION_ID=""
BACK4APP_PARSE_REST_API_KEY=""
```
No arquivo "lib/repositories/cep_back4app_repository.dart " coloque o caminho correspondente do seu app na variável url:

```dart
var url = "/cep";
```
