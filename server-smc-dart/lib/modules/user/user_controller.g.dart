// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UserControllerRouter(UserController service) {
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
