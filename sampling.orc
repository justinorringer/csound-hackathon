sr = 44100
kr = 4410
ksmps = 10
nchnls = 2
0dbfs = 1

        instr 1
iamp    =   p4
a1, a2  diskin "gonna.wav"
        outs a1*iamp, a2*iamp
        endin

; STORE AUDIO IN RAM USING GEN01 FUNCTION TABLE
giSoundFile   ftgen   0, 0, 0, 1, "gonna.wav", 0, 0, 0

  instr 2 ; play audio from function table using flooper2 opcode
kAmp         =         1   ; amplitude
kPitch       =         p4  ; pitch/speed
kLoopStart   =         0   ; point where looping begins (in seconds)
kLoopEnd     =         nsamp(giSoundFile)/sr; loop end (end of file)
kCrossFade   =         0   ; cross-fade time
; read audio from the function table using the flooper2 opcode
aSig         flooper2  kAmp,kPitch,kLoopStart,kLoopEnd,kCrossFade,giSoundFile
             out       aSig, aSig ; send audio to output
  endin
