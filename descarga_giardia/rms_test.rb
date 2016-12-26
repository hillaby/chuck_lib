#!/usr/bin/ruby

require_relative '../lib/rms_rand_loop'

# generate ck file
fname = "01"

if (ARGV[0] == "gen")
  RMSRandLoop.analyze(fname)
end

system("chuck ../lib/timer.ck ../lib/rec.ck ../lib/rms_rand_loop.ck ../lib/effects/effect.ck ../lib/effects/rand_lpf.ck ../lib/effects/stereo_effect.ck ../lib/effects/rand_pan.ck ../lib/instruments/instrument.ck ../lib/instruments/tri_bass.ck silence_arr_#{fname}.ck rms_test.ck") or raise
