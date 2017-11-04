#!/bin/sh

# --silent - remove it if you have enough CPU

chuck --srate44100 \
    --silent \
    ../lib/timer.ck \
    ../lib/rec.ck \
    ../lib/rand_loop.ck \
    ../lib/stereo_rand_loop.ck \
    chipmunx.ck
