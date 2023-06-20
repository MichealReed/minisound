import "dart:typed_data";

import "package:flutter_web_plugins/flutter_web_plugins.dart";
import "package:minisound_platform_interface/minisound_platform.dart";
import "package:minisound_web/bindings/minisound.dart" as wasm;
import "package:minisound_web/bindings/wasm/wasm.dart";

// minisound web
class MinisoundWeb extends MinisoundPlatform {
  MinisoundWeb._();

  static void registerWith(Registrar _) =>
      MinisoundPlatform.instance = MinisoundWeb._();

  @override
  EnginePlatform createEngine() {
    final self = wasm.engine_alloc();
    if (self == nullptr) throw MinisoundPlatformOutOfMemoryException();
    return EngineWeb(self);
  }
}

// engine web
final class EngineWeb implements EnginePlatform {
  EngineWeb(Pointer<wasm.Engine> self) : _self = self;

  final Pointer<wasm.Engine> _self;

  @override
  Future<void> init(int periodMs) async {
    if (await wasm.engine_init(_self, periodMs) != wasm.Result.Ok) {
      throw MinisoundPlatformException("Failed to init the engine.");
    }
  }

  @override
  void dispose() {
    wasm.engine_uninit(_self);
    malloc.free(_self); // TODO free when GC unloads an object
  }

  @override
  void start() {
    if (wasm.engine_start(_self) != wasm.Result.Ok) {
      throw MinisoundPlatformException("Failed to start the engine.");
    }
  }

  @override
  Future<SoundPlatform> loadSound(Uint8List data) async {
    // copy data into the memory
    final dataPtr = malloc.allocate(data.lengthInBytes);
    heap.copy(dataPtr, data);

    // create sound
    final sound = wasm.engine_load_sound(_self, dataPtr, data.lengthInBytes);
    if (sound == nullptr) {
      throw MinisoundPlatformException("Failed to load a sound.");
    }
    return SoundWeb._fromPtrs(sound, dataPtr);
  }

  @override
  void unloadSound(SoundPlatform sound) {
    sound as SoundWeb;

    wasm.engine_unload_sound(_self, sound._self);
    malloc.free(sound._data);
  }
}

// sound web
final class SoundWeb implements SoundPlatform {
  SoundWeb._fromPtrs(Pointer<wasm.Sound> self, Pointer data)
      : _self = self,
        _data = data,
        _volume = wasm.sound_get_volume(self),
        _duration = wasm.sound_get_duration(self);

  final Pointer<wasm.Sound> _self;
  final Pointer _data;

  double _volume;
  @override
  double get volume => _volume;
  @override
  set volume(double value) {
    wasm.sound_set_volume(_self, value);
    _volume = value;
  }

  final double _duration;
  @override
  double get duration => _duration;

  @override
  void play() {
    if (wasm.sound_play(_self) != wasm.Result.Ok) {
      throw MinisoundPlatformException("Failed to play the sound.");
    }
  }

  @override
  void pause() => wasm.sound_pause(_self);
  @override
  void stop() => wasm.sound_stop(_self);
}
