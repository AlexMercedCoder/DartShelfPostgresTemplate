// Ensure that the build script itself is not opted in to null safety,
// instead of taking the language version from the current package.
//
// @dart=2.9
//
// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:build_test/builder.dart' as _i2;
import 'package:build_config/build_config.dart' as _i3;
import 'package:envify_generator/builder.dart' as _i4;
import 'package:source_gen/builder.dart' as _i5;
import 'package:build_modules/builders.dart' as _i6;
import 'package:build_web_compilers/builders.dart' as _i7;
import 'package:build/build.dart' as _i8;
import 'dart:isolate' as _i9;
import 'package:build_runner/build_runner.dart' as _i10;
import 'dart:io' as _i11;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
      r'build_test:test_bootstrap',
      [_i2.debugIndexBuilder, _i2.debugTestBuilder, _i2.testBootstrapBuilder],
      _i1.toRoot(),
      hideOutput: true,
      defaultGenerateFor:
          const _i3.InputSet(include: [r'$package$', r'test/**'])),
  _i1.apply(r'envify_generator:envify', [_i4.envifyBuilder],
      _i1.toDependentsOf(r'envify_generator'),
      hideOutput: true,
      appliesBuilders: const [r'source_gen:combining_builder']),
  _i1.apply(r'source_gen:combining_builder', [_i5.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: const [r'source_gen:part_cleanup']),
  _i1.apply(r'build_modules:module_library', [_i6.moduleLibraryBuilder],
      _i1.toAllPackages(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [r'build_modules:module_cleanup']),
  _i1.apply(
      r'build_web_compilers:dart2js_modules',
      [
        _i7.dart2jsMetaModuleBuilder,
        _i7.dart2jsMetaModuleCleanBuilder,
        _i7.dart2jsModuleBuilder
      ],
      _i1.toNoneByDefault(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [r'build_modules:module_cleanup']),
  _i1.apply(
      r'build_web_compilers:ddc_modules',
      [
        _i7.ddcMetaModuleBuilder,
        _i7.ddcMetaModuleCleanBuilder,
        _i7.ddcModuleBuilder
      ],
      _i1.toNoneByDefault(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [r'build_modules:module_cleanup']),
  _i1.apply(
      r'build_web_compilers:ddc',
      [
        _i7.ddcKernelBuilderUnsound,
        _i7.ddcBuilderUnsound,
        _i7.ddcKernelBuilderSound,
        _i7.ddcBuilderSound
      ],
      _i1.toAllPackages(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [
        r'build_web_compilers:ddc_modules',
        r'build_web_compilers:dart2js_modules',
        r'build_web_compilers:dart_source_cleanup'
      ]),
  _i1.apply(
      r'build_web_compilers:sdk_js',
      [_i7.sdkJsCompileUnsound, _i7.sdkJsCompileSound, _i7.sdkJsCopyRequirejs],
      _i1.toNoneByDefault(),
      isOptional: true,
      hideOutput: true),
  _i1.apply(r'build_web_compilers:entrypoint', [_i7.webEntrypointBuilder],
      _i1.toRoot(),
      hideOutput: true,
      defaultGenerateFor: const _i3.InputSet(include: [
        r'web/**',
        r'test/**.dart.browser_test.dart',
        r'example/**',
        r'benchmark/**'
      ], exclude: [
        r'test/**.node_test.dart',
        r'test/**.vm_test.dart'
      ]),
      defaultOptions: _i8.BuilderOptions({
        'dart2js_args': ['--minify']
      }),
      defaultDevOptions: _i8.BuilderOptions({
        'dart2js_args': ['--enable-asserts']
      }),
      defaultReleaseOptions: _i8.BuilderOptions({'compiler': 'dart2js'}),
      appliesBuilders: const [
        r'build_web_compilers:dart2js_archive_extractor'
      ]),
  _i1.applyPostProcess(r'build_modules:module_cleanup', _i6.moduleCleanup),
  _i1.applyPostProcess(r'build_web_compilers:dart2js_archive_extractor',
      _i7.dart2jsArchiveExtractor,
      defaultReleaseOptions: _i8.BuilderOptions({'filter_outputs': true})),
  _i1.applyPostProcess(
      r'build_web_compilers:dart_source_cleanup', _i7.dartSourceCleanup,
      defaultReleaseOptions: _i8.BuilderOptions({'enabled': true})),
  _i1.applyPostProcess(r'source_gen:part_cleanup', _i5.partCleanup)
];
void main(List<String> args, [_i9.SendPort sendPort]) async {
  var result = await _i10.run(args, _builders);
  sendPort?.send(result);
  _i11.exitCode = result;
}
