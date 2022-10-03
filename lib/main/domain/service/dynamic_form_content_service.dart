import '../interface/i_dynamic_form_content_repository.dart';
import '../model/dynamic_form_content.dart';

class DynamicFormContentService {
  final IDynamicFormContentRepository iDynamicFormContentRepository;

  DynamicFormContentService({required this.iDynamicFormContentRepository});

  Future<List<DynamicFormContent>> getDynamicFormContent(String idForm) async {
    return await iDynamicFormContentRepository.getDynamicFormContent(idForm);
  }
}
