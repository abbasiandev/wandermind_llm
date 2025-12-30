// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatControllerHash() => r'c1a09bbe0ca4a7a1ef74985f5b799cd76560cf0c';

/// See also [ChatController].
@ProviderFor(ChatController)
final chatControllerProvider = AutoDisposeAsyncNotifierProvider<ChatController,
    List<ChatMessage>>.internal(
  ChatController.new,
  name: r'chatControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatController = AutoDisposeAsyncNotifier<List<ChatMessage>>;
String _$chatInputControllerHash() =>
    r'b517be767286a9c012203cfc69e978d0bee057e4';

/// See also [ChatInputController].
@ProviderFor(ChatInputController)
final chatInputControllerProvider =
    AutoDisposeNotifierProvider<ChatInputController, ChatInputState>.internal(
  ChatInputController.new,
  name: r'chatInputControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatInputControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatInputController = AutoDisposeNotifier<ChatInputState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
