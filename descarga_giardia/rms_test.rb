#!/usr/bin/ruby

require_relative '../lib/rms_rand_loop'

# generate ck file
fname = "01"

dac = ""
0.upto(ARGV.length - 1) { |cur_arg|
    if (ARGV[cur_arg] == "gen")
        RMSRandLoop.analyze(fname)
    elsif (ARGV[cur_arg] =~ /(--dac:\d+)/)
        dac = $1
    end
}

system("chuck #{dac} ../lib/timer.ck ../lib/rec.ck ../lib/rms_rand_loop.ck ../lib/effects/effect.ck ../lib/effects/rand_lpf.ck ../lib/effects/stereo_effect.ck ../lib/effects/rand_pan.ck ../lib/instruments/instrument.ck ../lib/instruments/tri_bass.ck silence_arr_#{fname}.ck rms_test.ck") or raise
