import 'package:hive/hive.dart';

part 'imc_hive_model.g.dart';

@HiveType(typeId: 1)
class IMCHiveModel extends HiveObject {
  @HiveField(0)
  double peso = 0;
  @HiveField(1)
  double altura = 0;
  @HiveField(2)
  String resultado = "";

  IMCHiveModel();

  IMCHiveModel.criar(this.peso, this.altura, this.resultado);
}
