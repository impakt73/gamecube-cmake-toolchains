set(CMAKE_SYSTEM_NAME      Generic) # Must be "Generic" - otherwise CMake expects it in its distribution.
set(CMAKE_SYSTEM_PROCESSOR powerpc)
set(CMAKE_SYSTEM_VERSION   1.0)
set(CMAKE_SYSTEM           ${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_VERSION})

set(DevKitPro_Platform "GameCube")

set(DevKitPro_ABI "eabi")
set(DevKitPro_Target "${CMAKE_SYSTEM_PROCESSOR}-${DevKitPro_ABI}")

if(NOT DEFINED ENV{DEVKITPRO})
    message(FATAL_ERROR "The DEVKITPRO environment variable must be defined in order to use this toolchain!")
endif()

set(DevKitPro "$ENV{DEVKITPRO}")

set(DevKitProPPC    "${DevKitPro}/devkitPPC")
set(DevKitPro_Bin   "${DevKitProPPC}/bin")
set(DevKitPro_Tools "${DevKitProPPC}/${DevKitPro_Target}")

if(WIN32)
    set(BINARY_EXT ".exe")
else()
    set(BINARY_EXT "")
endif()

set(CMAKE_C_COMPILER   "${DevKitPro_Bin}/${DevKitPro_Target}-gcc${BINARY_EXT}")
set(CMAKE_CXX_COMPILER "${DevKitPro_Bin}/${DevKitPro_Target}-g++${BINARY_EXT}")


foreach(LANG C CXX)
    set(CMAKE_${LANG}_FLAGS_INIT "-DGEKKO -mcpu=750 -meabi -mhard-float -mogc")
    set(CMAKE_${LANG}_STANDARD_INCLUDE_DIRECTORIES
        "${DevKitProPPC}/lib/gcc/${DevKitPro_Target}/8.3.0/include"
        "${DevKitPro_Tools}/include/c++/8.3.0"
        "${DevKitPro_Tools}/include"
        "${DevKitPro}/libogc/include"
    )
    set(CMAKE_${LANG}_STANDARD_LIBRARIES "-logc -lm")
    set(CMAKE_EXECUTABLE_SUFFIX_${LANG} ".elf")
endforeach()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_EXE_LINKER_FLAGS "-L${DevKitPro_Tools}/lib -L${DevKitPro}/libogc/lib/cube")
