public class Horns
{
    Echo echoLeft => Gain gainLeft => Gain feedbackLeft => echoLeft;
    (1.0/6.0)::AATimer.get_T() => echoLeft.delay;
    .16 => echoLeft.mix;
    1::AATimer.get_T() => echoLeft.max;
    .53 => feedbackLeft.gain;

    Echo echoRight => Gain gainRight => Gain feedbackRight => echoRight;
    (1.0/6.0)::AATimer.get_T() => echoRight.delay;
    .16 => echoRight.mix;
    1::AATimer.get_T() => echoRight.max;
    .53 => feedbackRight.gain;

    Pan2 rightPan;
    rightPan.left => echoLeft;
    rightPan.right => echoRight;
    rightPan.pan(0.4);

    Pan2 leftPan;
    leftPan.left => echoLeft;
    leftPan.right => echoRight;
    leftPan.pan(-0.4);

    SndBuf sax => ADSR sax_adsr => Gain sax_gain => leftPan;

    "saxophone-tenor-C-octave1-vib.wav" => sax.read;
    //.0 => sax.gain;
    .535 => sax.gain;
    sax_adsr.set( 10::ms, 8::ms, .8, 100::ms );

    SndBuf sax2 => ADSR sax2_adsr => Gain sax2_gain => rightPan;

    "saxophone-alto-C-octave1-vib.wav" => sax2.read;
    .5 => sax2.gain;
    sax2_adsr.set( 10::ms, 8::ms, .8, 100::ms );

    SndBuf trp => ADSR trp_adsr => Gain trp_gain => leftPan;
    "trpt-C-hi.wav" => trp.read;
    .7 => trp.gain;
    //.0 => trp.gain;
    trp_adsr.set( 10::ms, 8::ms, .8, 100::ms );

    SndBuf trp2 => ADSR trp2_adsr => Gain trp2_gain => rightPan;
    "trpt-C-hi.wav" => trp2.read;
    .62 => trp2.gain;
    //.0 => trp.gain;
    trp2_adsr.set( 10::ms, 8::ms, .8, 100::ms );


    off();
    spork ~ play();

    public void sax_note(float n, float d)
    {
        .2*d*AATimer.get_T() => sax_adsr.releaseTime;

        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(60) + Std.randf()*.008 => sax.rate;
        2000=>sax.pos;
        //0=>sax.pos;
        sax_adsr.keyOn();
        .8*d => AATimer.advance;

        sax_adsr.keyOff();
        .2*d => AATimer.advance;
    }

    public void sax2_note(float n, float d)
    {
        .2*d*AATimer.get_T() => sax2_adsr.releaseTime;
        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(72) + Std.randf()*.008 => sax2.rate;
        1200=>sax2.pos;
        //0=>sax.pos;
        sax2_adsr.keyOn();
        .8*d => AATimer.advance;

        sax2_adsr.keyOff();
        .2*d => AATimer.advance;
    }

    public void trp_note(float n, float d)
    {
        .2*d*AATimer.get_T() => trp_adsr.releaseTime;

        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(60) + Std.randf()*.012 => trp.rate;
        100=>trp.pos;
        trp_adsr.keyOn();
        .8*d => AATimer.advance;

        trp_adsr.keyOff();
        .2*d => AATimer.advance;
    }

    public void trp2_note(float n, float d)
    {
        .2*d*AATimer.get_T() => trp2_adsr.releaseTime;

        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(60) + Std.randf()*.012 => trp2.rate;
        100=>trp2.pos;
        trp2_adsr.keyOn();
        .8*d => AATimer.advance;

        trp2_adsr.keyOff();
        .2*d => AATimer.advance;
    }

    public void unison(float n, float d)
    {
        spork ~ sax_note(n,d);
        spork ~ trp2_note(n,d);
        //spork ~ sax2_note(n,d);
        trp_note(n,d);
    }

    0=>int what_to_play;

    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                //<<< "nn" >>>;
                spork~unison(64, .125);
                sax2_note(69,.125);

                spork~unison(65, .125);
                sax2_note(71,.125);

                spork~unison(67, .125);
                sax2_note(72,.125);
                .125 => AATimer.advance;

                spork~unison(66, .125);
                sax2_note(71,.125);
                .125 => AATimer.advance;

                spork~unison(64, .125);
                sax2_note(69,.125);
                .125 => AATimer.advance;

                spork~unison(62, .125);
                sax2_note(67,.125);
                .125 => AATimer.advance;

                spork~unison(67, .125);
                sax2_note(71,.125);
                .125 => AATimer.advance;
                spork~unison(66, .125);
                sax2_note(70,.125);
                .125 => AATimer.advance;
                spork~unison(67, .125);
                sax2_note(71,.125);
                .125 => AATimer.advance;

                //////////////////////

                //<<< "nn" >>>;
                spork~unison(64, .125);
                sax2_note(69,.125);

                spork~unison(65, .125);
                sax2_note(71,.125);

                spork~unison(67, .125);
                sax2_note(72,.125);
                .125 => AATimer.advance;

                spork~unison(66, .125);
                sax2_note(71,.125);
                .125 => AATimer.advance;

                spork~unison(64, .125);
                sax2_note(69,.125);
                .125 => AATimer.advance;

                spork~unison(62, .125);
                sax2_note(67,.125);
                .125 => AATimer.advance;

                .75 => AATimer.advance;

                //<<< "nn" >>>;
                spork~unison(60, .125);
                sax2_note(64,.125);

                spork~unison(62, .125);
                sax2_note(65,.125);

                spork~unison(64, .125);
                sax2_note(67,.125);
                .125 => AATimer.advance;

                spork~unison(62, .125);
                sax2_note(65,.125);
                .125 => AATimer.advance;

                spork~unison(60, .125);
                sax2_note(64,.125);
                .125 => AATimer.advance;

                spork~unison(59, .125);
                sax2_note(62,.125);
                .125 => AATimer.advance;

                spork~unison(62, .125);
                sax2_note(67,.125);
                .125 => AATimer.advance;
                spork~unison(61, .125);
                sax2_note(66,.125);
                .125 => AATimer.advance;
                spork~unison(62, .125);
                sax2_note(67,.125);
                .125 => AATimer.advance;


                //////////////////////

                //<<< "nn" >>>;
                spork~unison(60, .125);
                sax2_note(64,.125);

                spork~unison(62, .125);
                sax2_note(65,.125);

                spork~unison(64, .125);
                sax2_note(67,.125);
                .125 => AATimer.advance;

                spork~unison(62, .125);
                sax2_note(65,.125);
                .125 => AATimer.advance;

                spork~unison(60, .125);
                sax2_note(64,.125);
                .375 => AATimer.advance;

                spork~unison(59, .125);
                sax2_note(62,.125);
                .125 => AATimer.advance;
                spork~unison(62, .125);
                sax2_note(65,.125);
                .125 => AATimer.advance;
                spork~unison(65, .125);
                sax2_note(68,.125);
                .125 => AATimer.advance;
                //.75 => AATimer.advance;
            }
            else
            {
                // new riff
                unison(60, .25);
                //sax2_note(60,.25);
                .125 => AATimer.advance;
                unison(63, .125);
                //sax2_note(57,.125);
                unison(65, .125);
                //sax2_note(60,.125);
                unison(66, .25);
                //sax2_note(62,.25);
                unison(62, .125);
                //sax2_note(62,.125);

                unison(67, .125);
                //sax2_note(60,.125);
                unison(67, .125);
                //sax2_note(60,.125);
                unison(65, .125);
                //sax2_note(62,.125);
                .125 => AATimer.advance;
                unison(63, .125);
                //sax2_note(63,.125);
                .125 => AATimer.advance;
                unison(58, .125);
                //sax2_note(62,.125);
                .125 => AATimer.advance;

                ///////////////

                unison(60, .25);
                //sax2_note(60,.25);
                .125 => AATimer.advance;
                unison(63, .125);
                //sax2_note(57,.125);
                unison(65, .125);
                //sax2_note(62,.125);
                unison(66, .25);
                //sax2_note(66,.25);
                unison(62, .125);
                //sax2_note(62,.125);

                unison(67, .5);
                //sax2_note(60,.5);
                .5=>AATimer.advance;

                ///////////////

                unison(60, .25);
                //sax2_note(60,.25);
                .125 => AATimer.advance;
                unison(63, .125);
                //sax2_note(57,.125);
                unison(65, .125);
                //sax2_note(60,.125);
                unison(66, .25);
                //sax2_note(62,.25);
                unison(62, .125);
                //sax2_note(62,.125);

                unison(67, .125);
                //sax2_note(60,.125);
                unison(67, .125);
                //sax2_note(60,.125);
                unison(65, .125);
                //sax2_note(62,.125);
                .125 => AATimer.advance;
                unison(63, .125);
                //sax2_note(63,.125);
                .125 => AATimer.advance;
                unison(58, .125);
                //sax2_note(60,.125);
                .125 => AATimer.advance;

                ///////////////

                unison(64, .125);
                //sax2_note(60,.125);
                unison(64, .125);
                //sax2_note(60,.125);
                unison(62, .125);
                //sax2_note(62,.125);
                .125 => AATimer.advance;
                unison(60, .125);
                //sax2_note(63,.125);
                .125 => AATimer.advance;
                unison(57, .125);
                //sax2_note(60,.125);
                .125 => AATimer.advance;
                unison(55, .125);
                //sax2_note(55,.125);
                .125 => AATimer.advance;
                unison(58, .125);
                //sax2_note(58,.125);
                .125 => AATimer.advance;
                unison(60, .125);
                //sax2_note(60,.125);
                .375 => AATimer.advance;
            }
        }
    }

    public void set_what_to_play(int w)
    {
        w=>what_to_play;
    }

    public void connectLeft(UGen ug)
    {
        gainLeft => ug;
    }

    public void connectRight(UGen ug)
    {
        gainRight => ug;
    }


    public void sax_on(float g)
    {
        g=>sax_gain.gain;
        g=>sax2_gain.gain;
    }

    public void trp_on(float g)
    {
        g=>trp_gain.gain;
        g=>trp2_gain.gain;
    }

    public void off()
    {
        0=>sax_gain.gain;
        0=>sax2_gain.gain;
        0=>trp_gain.gain;
        0=>trp2_gain.gain;
    }
}
