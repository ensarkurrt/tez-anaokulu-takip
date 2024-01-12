import '../../service_layer/logger/logger.dart';
import '../../service_layer/providers/state_management.dart';

Future serviceLoader<E>(Function callback, {Function(E)? onError, bool showLoader = true}) async {
  try {
    Logger.instance.log("SERVICE LOADER ::: START");
    StateManagement.include.changeStateBusy();
    Logger.instance.log("SERVICE LOADER ::: MIDDLE");
    return await callback();
    // ignore: nullable_type_in_catch_clause
  } on E catch (e) {
    Logger.instance.log("SERVICE LOADER2 ::: $e");
    await onError?.call(e);
  } catch (e) {
    Logger.instance.log("SERVICE LOADER ::: $e");
  } finally {
    StateManagement.include.state = ViewStateEnum.Idle;
  }
}
