import 'package:hive/hive.dart';
import 'package:meu_app_imc_2/models/imc_hive_model.dart';

class IMCHiveRepository {
  static late Box _box;

  IMCHiveRepository._criar();

  static String iMCKey = "iMCKey";

  static Future<IMCHiveRepository> carregar() async {
    if (Hive.isBoxOpen(iMCKey)) {
      _box = Hive.box(iMCKey);
    } else {
      _box = await Hive.openBox(iMCKey);
    }
    return IMCHiveRepository._criar();
  }

  salvar(IMCHiveModel imcHiveModel) {
    _box.add(imcHiveModel);
  }

  excluir(IMCHiveModel imcHiveModel) {
    imcHiveModel.delete();
  }

  List<IMCHiveModel> obterDados() {
    return _box.values.cast<IMCHiveModel>().toList();
  }
}
