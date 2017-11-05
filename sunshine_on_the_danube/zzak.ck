spork~Rec.recMono("Sunshine_on_the_Danube") @=> Shred aarec;

Baterista drums;
Bass bass;

Gain gain => Gain limiting => Dyno dy => dac;

SndBuf rec => gain;
"dallam_mono.wav"=>rec.read;
0=>rec.gain;

SndBuf ride_roll => gain;
"cymbal-ride-roll-long.wav"=>ride_roll.read;
0=>ride_roll.gain;

dy.limit();
.65=>dy.thresh;
.15=>dy.slopeAbove;

.50 => gain.gain;
.90=>limiting.gain;

1270::ms => dur T;
drums.set_T(T);
bass.set_T(T);

bass.set_what_to_play(1); // sz�n
drums.connect(gain);
bass.connect(gain);

1::T=>now;

1=>ride_roll.gain;
0=>ride_roll.pos;

.95::T=>now;

bass.set_what_to_play(0);

.05::T=>now;

drums.on(.85);
bass.on(.8);
39000=>rec.pos;

.4=>rec.gain;
.125::T=>now;
.75=>rec.gain;
//48000=>rec.pos;

7.875::T=>now;

1::T=>now;

1245::ms => T;
drums.set_T(T);
bass.set_T(T);

4::T=>now;

1237::ms => T;
drums.set_T(T);
bass.set_T(T);

2::T=>now;

1255::ms=>T;
drums.set_T(T);
bass.set_T(T);

.45::T=>now;

drums.set_what_to_play(1);
bass.set_what_to_play(2);
0.05::T=>now;

//1310::ms => T;
//drums.set_T(T);
//bass.set_T(T);

.5::T=>now;

//////////////////////////////////////////////

1155::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
1110::ms => T;
drums.set_T(T);
bass.set_T(T);
1::T=>now;

1::T=>now;

1::T=>now;

1::T=>now;

4::T=>now;
//while(true) 1::T=>now;

2::T=>now;
1120::ms => T;
drums.set_T(T);
bass.set_T(T);

1::T=>now;

1::T=>now;

///////////////////////

1110::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;

1120::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;

1122::ms => T;
drums.set_T(T);
bass.set_T(T);
3::T=>now;

//1100::ms => T;
1::T=>now;

/////////////////////

1085::ms => T;
drums.set_T(T);
bass.set_T(T);
1::T=>now;

3::T=>now;

3.45::T=>now;
drums.set_what_to_play(2);
bass.set_what_to_play(3);
.55::T=>now;

/////////////////////OK
1033::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
1032::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
1035::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
1039::ms => T;
drums.set_T(T);
bass.set_T(T);
3.95::T=>now;

drums.set_what_to_play(1);
bass.set_what_to_play(4);
.05::T=>now;

1135::ms => T;
drums.set_T(T);
bass.set_T(T);

3.95::T=>now;

drums.set_what_to_play(0);
bass.set_what_to_play(0);
.05::T=>now;

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

1190::ms => T;
drums.set_T(T);
bass.set_T(T);

8::T=>now;

1::T=>now;

1160::ms => T;
drums.set_T(T);
bass.set_T(T);

4::T=>now;

2::T=>now;

1200::ms=>T;
drums.set_T(T);
bass.set_T(T);

.45::T=>now;

drums.set_what_to_play(1);
bass.set_what_to_play(2);
0.05::T=>now;

1300::ms => T;
drums.set_T(T);
bass.set_T(T);

.5::T=>now;

//////////////////////////////////////////////

1175::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
1090::ms => T;
drums.set_T(T);
bass.set_T(T);
1::T=>now;

1::T=>now;

1100::ms => T;
drums.set_T(T);
bass.set_T(T);

1::T=>now;

1::T=>now;

1120::ms => T;
drums.set_T(T);
bass.set_T(T);

4::T=>now;
//while(true) 1::T=>now;

2::T=>now;
1120::ms => T;
drums.set_T(T);
bass.set_T(T);

1::T=>now;

1::T=>now;

///////////////////////

1180::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;

1180::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;

1122::ms => T;
drums.set_T(T);
bass.set_T(T);
3::T=>now;

/*1100::ms => T;
drums.set_T(T);
bass.set_T(T);*/
1::T=>now;

/////////////////////

1100::ms => T;
drums.set_T(T);
bass.set_T(T);
4::T=>now;

1120::ms => T;
drums.set_T(T);
bass.set_T(T);

3.45::T=>now;
drums.set_what_to_play(2);
bass.set_what_to_play(3);
.55::T=>now;

/////////////////////OK
1035::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
1033::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
1039::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
drums.set_T(T);
bass.set_T(T);
4::T=>now;

1031::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
drums.set_T(T);
bass.set_T(T);
4::T=>now;

990::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
2::T=>now;
2::T=>now;
4::T=>now;

1015::ms => T;
drums.set_T(T);
bass.set_T(T);
8::T=>now;
1000::ms => T;
drums.set_T(T);
bass.set_T(T);
2::T=>now;
2::T=>now;
3.95::T=>now;

drums.set_what_to_play(3);
bass.set_what_to_play(5);

8.05::T=>now;

aarec.exit();
