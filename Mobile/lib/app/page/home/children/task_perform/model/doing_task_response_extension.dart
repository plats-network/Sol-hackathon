import 'package:plat_app/app/page/home/children/task_perform/model/doing_task_response.dart';

extension DoingTaskResponseExtension on DoingTaskResponse {
  DateTime? get timeStartOrginalDateTime {
    if (data?.timeStartOrginal != null) {
      try {
        final dt = DateTime.parse(data?.timeStartOrginal ?? '');
        return dt;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  DateTime? get timeEndOrginalDateTime {
    if (data?.timeEndOrginal != null) {
      try {
        final dt = DateTime.parse(data?.timeEndOrginal ?? '');
        return dt;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
