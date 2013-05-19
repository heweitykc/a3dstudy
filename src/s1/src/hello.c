/*
** ADOBE SYSTEMS INCORPORATED
** Copyright 2012 Adobe Systems Incorporated
** All Rights Reserved.
**
** NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
** terms of the Adobe license agreement accompanying it.  If you have received this file from a
** source other than Adobe, then your use, modification, or distribution of it requires the prior
** written permission of Adobe.
*/
#include <stdio.h>

int main(int argc, char **argv)
{
    // flascc comes with a normal BSD libc so everything you would expect to
    // be present should work out-of-the-box. This example just shows a
    // simple message formatted using printf.
    //
    // When compiled as a projector this message will be to stdout just like
    // a normal commandline application. When compiled to a SWF it will be
    // displayed in a textfield on the stage. This behavior is overrideable
    // as you will see in later samples.
    
    printf("Hello World\n");
}
