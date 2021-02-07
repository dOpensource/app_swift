# app_swift - A Cepstral Swift TTS engine interface

Copyright (C) 2006-2012 - Darren Sessions   
Portions Copyright (C) 2012, Cepstral LLC   
Portions Copyright (C) 2013 - 2016, Jeremy Kister   
Portions Copyright (C) 2019 - 2021, dOpenSource  

All rights reserved.

## Synopsis:

Provides a direct interface into the Cepstral text-to-speech engine for Asterisk eliminating
the need to write audio output files to the filesystem and then stream them back out.

Also provides multi-digit dtmf recognition with a max digits and a wait-for-digit timer very 
simular to the AGI 'get data' command.

## Requirements: 

- Asterisk development header files
- Cepstral Swift Text-to-Speech engine (version 5 or 6)

## Installation:  

```shell
./configure
make
sudo make install
sudo make reload
```

One-liner:

```shell
./configure && make && sudo make install && sudo make reload
```

For configuration options:

```shell
./configure --help
```

## Troubleshooting: 
                
### Check that the swift libraries are in your ld path  

```shell
grep 'swift' /etc/ld.so.conf
```

### Check that the appropriate channel driver is configured / loaded:  

In <your asterisk path>/modules.conf uncomment EITHER:
        
`;noload => chan_alsa.so` or `;noload => chan_oss.so`

Load the module if not loaded:  

```shell
asterisk -x 'module show like <your channel driver>'
asterisk -x 'module load <your channel driver>'

```

### The following alsa and oss libraries are needed for best compatibility:  

```shell
# rhel-based os
yum install -y alsa-lib alsa-lib-devel alsa-utils alsa-plugins-oss
# debian-based os
apt install -y libasound2 libasound2-dev alsa-base alsa-utils alsa-oss
```

### On some distributions you made need to copy asterisk.h to /usr/include

## Usage:        

- Type "core show application swift" at the Asterisk CLI prompt.

```
ast18-appswift*CLI> core show application swift

  -= Info about application 'Swift' =- 

[Synopsis]
Swift TTS engine and optionally listen for DTMF.                 

[Description]
This application streams tts audio from the Cepstral swift engine and will
additionally read DTMF into the ${SWIFT_DTMF} variable if the timeout and
digits options are used.  You may change the voice dynamically by setting the
channel variable SWIFT_VOICE.
in extensions.conf:
exten => s,1,Answer
exten => s,n,Swift(This is Swift talking in the default voice from swift.conf)
exten => s,n,Set(SWIFT_VOICE=Callie-8kHz)
exten => s,n,Swift(This is Swift talking in the Callie voice)
exten => s,n,Swift(Please enter three digits,5000,3)
exten => s,n,Swift(You entered ${SWIFT_DTMF}.  Goodbye)
exten => s,n,Hangup

[Syntax]
Swift(text[,options])

[Arguments]
text
    Text to Speak.
options
    timeout: Timeout in milliseconds.

    digits: Maxiumum digits.


[See Also]
Not available

```
