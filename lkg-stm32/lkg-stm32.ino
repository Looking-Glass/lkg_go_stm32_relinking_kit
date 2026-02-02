// clang-format off
#include <LkgLib.h>
#include <CircularBuffer.h>
#include <Wire.h>
#include <IWatchdog.h>
#include "ci.h"

LkgLib& mLkg = LkgLib::getInstance(CI_BUILD_NUM, CI_FW_VER);

void setup()
{
    mLkg.setup();
}

void loop()
{
    mLkg.loop();
}
