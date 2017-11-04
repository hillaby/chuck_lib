#!/bin/sh

chuck --srate44100 \
    --silent \
    ../lib/timer.ck \
    ../lib/rec.ck \
    ../lib/rand_loop.ck \
    ../lib/stereo_rand_loop.ck \
    christmas_storm_cha.ck
