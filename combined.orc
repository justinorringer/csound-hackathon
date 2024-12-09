sr = 44100
kr = 4410
ksmps = 10
nchnls = 2
0dbfs = 1

; STORE AUDIO IN RAM USING GEN01 FUNCTION TABLE
giSoundFile   ftgen    0, 0, 0, 1, "gonna.wav", 0, 0, 0
giSine        ftgen    1,0,1025,10,1
giTanh        ftgen    2,0,257,"tanh",-3,10,0

    instr 1 ; play audio from function table using flooper2 opcode
kAmp         =         1   ; amplitude
kPitch       =         p4  ; pitch/speed
kLoopStart   =         0   ; point where looping begins (in seconds)
kLoopEnd     =         nsamp(giSoundFile)/sr; loop end (end of file); nsamp returns num of samples in function
kCrossFade   =         0   ; cross-fade time
; read audio from the function table using the flooper2 opcode
aSigL, aSigR         flooper2  kAmp,kPitch,kLoopStart,kLoopEnd,kCrossFade,giSoundFile

kAmt         =         p5
aDst         distort   aSigL, kAmt, giTanh
; bringing back the original a bit more
aDstL        =         aDst*0.5 + aSigL*0.4
aDstR        =         aDst*0.5 + aSigR*0.4
;apply simple envelope
kenv         linen     1, p3/4, p3, p3/4
kenv         transeg   0.01, p3*0.25, p4, 1, p3*0.75, p5, 0.01
             outs      aDstL*kenv, aDstR*kenv
    endin
