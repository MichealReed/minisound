# CMAKE generated file: DO NOT EDIT!
# Generated by CMake Version 3.28
cmake_policy(SET CMP0009 NEW)

# MAIN_SOURCES at CMakeLists.txt:27 (file)
file(GLOB_RECURSE NEW_GLOB LIST_DIRECTORIES false "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/*/src/*.c")
set(OLD_GLOB
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/miniaudio/src/miniaudio.c"
  )
if(NOT "${NEW_GLOB}" STREQUAL "${OLD_GLOB}")
  message("-- GLOB mismatch!")
  file(TOUCH_NOCREATE "/home/Daniil/_work/_projects/_flutter/minisound/minisound_web/lib/js/CMakeFiles/cmake.verify_globs")
endif()

# MAIN_SOURCES at CMakeLists.txt:27 (file)
file(GLOB_RECURSE NEW_GLOB LIST_DIRECTORIES false "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/src/*.c")
set(OLD_GLOB
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/src/engine.c"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/src/silence_data_source.c"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/src/sound.c"
  )
if(NOT "${NEW_GLOB}" STREQUAL "${OLD_GLOB}")
  message("-- GLOB mismatch!")
  file(TOUCH_NOCREATE "/home/Daniil/_work/_projects/_flutter/minisound/minisound_web/lib/js/CMakeFiles/cmake.verify_globs")
endif()

# MAIN_INCLUDES at CMakeLists.txt:34 (file)
file(GLOB_RECURSE NEW_GLOB LIST_DIRECTORIES true "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/*/include/")
set(OLD_GLOB
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/milo/example"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/milo/example/include"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/milo/example/src"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/miniaudio/include"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/miniaudio/src"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/hooks"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/info"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/logs"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/logs/refs"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/logs/refs/heads"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/logs/refs/remotes"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/logs/refs/remotes/origin"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/00"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/05"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/06"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/0b"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/16"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/1a"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/27"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/3d"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/3f"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/41"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/4a"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/4b"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/72"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/7c"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/86"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/87"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/8a"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/8b"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/92"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/93"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/9d"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/9f"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/aa"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/bb"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/bc"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/bd"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/c2"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/c7"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/cd"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/ce"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/d7"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/d9"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/db"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/dc"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/e9"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/ea"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/f7"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/f8"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/info"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/objects/pack"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/refs"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/refs/heads"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/refs/remotes"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/refs/remotes/origin"
  "/home/Daniil/_work/_projects/_flutter/minisound/minisound_ffi/src/external/result/.git/refs/tags"
  )
if(NOT "${NEW_GLOB}" STREQUAL "${OLD_GLOB}")
  message("-- GLOB mismatch!")
  file(TOUCH_NOCREATE "/home/Daniil/_work/_projects/_flutter/minisound/minisound_web/lib/js/CMakeFiles/cmake.verify_globs")
endif()
