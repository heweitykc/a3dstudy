#include <stdlib.h>
#include <math.h>
#include <AS3/AS3.h>
#include <Flash++.h>
using namespace AS3::ui;

// Some global vars we'll use in various functions.
flash::display::Stage stage;
flash::display::BitmapData bmd;

uint32_t dir[8] = {-1, 1, 0, 0, 0, 0, 0, 0};
uint32_t dir2[4] = {0, 1, 0, 0};
uint32_t xd,yd;
uint32_t length;

uint32_t* universe_current;
uint32_t* universe_future;
uint32_t* vs;

flash::utils::ByteArray ram;

static var enterFrame(void *arg, var as3Args)
{
	for (uint32_t i = 0; i < length; i++)
    {
        uint32_t livecount = 0;
		uint32_t j;
        for (j = 0; j < 8; j++)
        {
            uint32_t index = i + dir[j];
            if (index >= 0 && index < length && universe_current[index] == 0)
                livecount++;
        }
        if (universe_current[i] == 0)
        {
            if (livecount != 2 && livecount != 3)
                universe_future[i] = 0xffffff;
            else
                universe_future[i] = 0;
        }
        else
        {
            if (livecount == 3)
                universe_future[i] = 0;
            else
                universe_future[i] = 0xffffff;
        }
        uint32_t i2 = (uint32_t(i / xd) * 3 * xd + (i % xd)) * 3;

        for (j = 0; j < 4; j++)
        {
            vs[i2 + dir2[j]] = universe_current[i];
			//ram->position = (i2 + dir2[j])*4;
			//ram->writeUnsignedInt(universe_current[i]);
        }
    }
    //bmd->lock();
    //bmd.setVector(bmd.rect, vs);
	//bmd->setVector(bmd->rect,ram);
	//bmd->fillRect(bmd->rect,0xCCCC00);
    //bmd->unlock();
    uint32_t* tmp = universe_current;
    universe_current = universe_future;
    universe_future = tmp;
	return internal::_undefined;
}

int main(int argc, char **argv)
{
	stage = internal::get_Stage();
    stage->scaleMode = flash::display::StageScaleMode::NO_SCALE;
    stage->align = flash::display::StageAlign::TOP_LEFT;
    stage->frameRate = 60;
	stage->quality =flash::display::StageQuality::LOW;

	//inline_as3("%0 = Math.min(800,%1) / 3;" : "=r"(xd) : "r"(stage->stageWidth));
	//inline_as3("%0 = Math.min(600,%1) / 3;": "=r"(yd) : "r"(stage->stageHeight));
	xd = 800/3;
	yd = 600/3;
	length = xd * yd;
	AS3_Trace("hi");
	dir[2] = xd;
	dir[3] = -xd;
	dir[4] = xd+1;
	dir[5] = xd-1;
	dir[6] = -xd+1;
	dir[7] = -xd-1;

	dir2[2] = xd * 3;
	dir2[3] = xd * 3 + 1;
	inline_as3("trace(\"inline xd = \"+%0+\",yd=\"+%1);" : : "r"(xd),"r"(yd));
	//bmd = flash::display::BitmapData::_new(xd * 3, yd * 3,false,0);
	//flash::display::Bitmap myBitmap = flash::display::Bitmap::_new(bmd);
	//stage->addChild(myBitmap);

	universe_current = (uint32_t*)malloc(4 * length);
	universe_future = (uint32_t*)malloc(4 * length);
	vs  = (uint32_t*)malloc(4 * length * 9);	
	//ram = internal::get_ram();
	
	int i;
	for (i = 0; i < length; i++)
	{
		//universe_current[i] = Math.random() < .5 ? 0 : 0xffffff;
		inline_as3("%0=Math.random() < .5 ? 0 : 0xffffff;" : "=r"(universe_current[i]) : );
	}
	for (i = 0; i < length*9; i++)
	{
		vs[i] = 0x000000;
	}
	stage->addEventListener(flash::events::Event::ENTER_FRAME, Function::_new(enterFrame, NULL));
	
	AS3_GoAsync();
	return 0;
}