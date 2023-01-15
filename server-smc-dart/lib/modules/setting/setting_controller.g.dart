// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$SettingControllerRouter(SettingController service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.created,
  );
  router.add(
    'DELETE',
    r'/',
    service.delete,
  );
  return router;
}
