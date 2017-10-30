#!/bin/bash

# might want to remove --silent option if you have enough CPU power

chuck \
  --silent \
  --srate44100 \
  ../lib/timer.ck \
  ../lib/rec.ck \
  ../lib/effects/effect.ck \
  ../lib/effects/stereo_effect.ck \
  ../lib/effects/stereo_echo.ck \
  ../lib/effects/overdrive.ck \
  ../lib/instruments/instrument.ck \
  ../lib/instruments/bass_drum.ck \
  ../lib/instruments/s_bass_drum.ck \
  ../lib/instruments/s_aggressive_snare.ck \
  ../lib/instruments/talking_bass.ck \
  ../lib/instruments/s_talking_bass.ck \
  ../lib/instruments/reggae_pluck.ck \
  ../lib/instruments/chord_player.ck \
  ../lib/instruments/s_hihat.ck \
  ../lib/instruments/tom.ck \
  ../lib/instruments/s_tom.ck \
  ../lib/instruments/s_bowed_glass.ck \
  ../lib/instruments/bowed_string.ck \
  ../lib/instruments/s_trumpet.ck \
  ../lib/instruments/s_marimba.ck \
  drum.ck \
  bass.ck \
  chords.ck \
  theme.ck \
  zzak.ck
