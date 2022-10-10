import '../model/dynamic_form.dart';

abstract class IDynamicFormRepository {
  Future<DynamicForm> getDynamicForm(String idForm);
}
