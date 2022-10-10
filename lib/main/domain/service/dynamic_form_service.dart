import '../interface/i_dynamic_form_repository.dart';
import '../model/dynamic_form.dart';

class DynamicFormService {
  final IDynamicFormRepository iDynamicFormRepository;

  DynamicFormService({required this.iDynamicFormRepository});

  Future<DynamicForm> getDynamicForm(String idForm) async {
    return await iDynamicFormRepository.getDynamicForm(idForm);
  }
}
