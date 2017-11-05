public class Baterista
{

    1300::ms => dur T;


    SndBuf hihat => Gain gain;
    "cymbal-hihat-open-stick-1.wav" => hihat.read;
    0 => hihat.gain;

    SndBuf hhclose => gain;
    "cymbal-hihat-stick.wav" => hhclose.read;
    0 => hhclose.gain;

    SndBuf snare => gain;
    "drum-snare-tap.wav" => snare.read;
    0 => snare.gain;

    SndBuf bass => gain;
    "drum-bass-lo-1.wav" => bass.read;
    0 => bass.gain;

    SndBuf tom => gain;
    "drum-tom-hi-tap.wav" => tom.read;
    0 => tom.gain;


    SndBuf splash => gain;
    "cymbal-splash-stick.wav" => splash.read;
    0 => splash.gain;

    SndBuf sizzle => gain;
    "cymbal-ride-bell.wav" => sizzle.read;
    0=>sizzle.gain;

    // sync
    T - (now % (2*T)) => now;

    off();
    spork ~ play();

    0=>int what_to_play;

    0=>int cycle;

    public void play()
    {
        while(true)
        {
            <<<cycle++>>>;

            if (what_to_play == 0)
            {
                2=>bass.gain;
                0=>bass.pos;
                .43=>hihat.gain;
                0=>hihat.pos;
                .25::T=>now;
                .6=>hhclose.gain;
                0=>hhclose.pos;
                .125::T=>now;

                1.3=>snare.gain;
                0=>snare.pos;

                0=>hihat.pos;
                .25::T=>now;
                0=>hhclose.pos;
                .125::T=>now;
                if (Std.randf() > 0.1)
                {
                    0=>snare.pos;
                }
                0=>hihat.pos;
                .25::T=>now;

                1=>bass.gain;
                0=>bass.pos;
                1=>hihat.gain;
                0=>hihat.pos;
                .25::T=>now;
                1=>hhclose.gain;
                0=>hhclose.pos;
                if (Std.randf() > -0.5)
                {
                    0=>snare.pos;
                }
                .125::T=>now;
                0=>hihat.pos;
                .125::T=>now;


            }
            else if (what_to_play == 1)
            {
                2=>bass.gain;
                0=>bass.pos;
                1.2=>sizzle.gain;

                0=>sizzle.pos;
                .25::T=>now;
                .8=>tom.gain;
                0=>snare.pos;
                .25::T=>now;
                0=>tom.pos;
                .25::T=>now;
                0=>tom.pos;
                0=>bass.pos;

                0=>sizzle.pos;
                .5::T=>now;

                0=>snare.pos;
                .25::T=>now;


            }
            else if (what_to_play == 2)
            {
                0=>bass.pos;
                0=>hihat.pos;
                .5::T=>now;
                0=>snare.pos;
                0=>hihat.pos;
                .25::T=>now;
                0=>snare.pos;
                .25::T=>now;
                0=>bass.pos;
                0=>hihat.pos;
                .5::T=>now;

            }

            else
            {
                0=>bass.pos;
                0=>hihat.pos;
                8::T=>now;
            }

            if (what_to_play == 0)
            {
                .125::T=>now;
                0=>hhclose.pos;
                .125::T=>now;

                0=>snare.pos;
                .125::T=>now;
                0=>snare.pos;
                .125::T=>now;

            }
            else if (what_to_play == 1)
            {

                0=>bass.pos;
                /*1=>splash.gain;
                0=>splash.pos;*/
                0=>sizzle.pos;
                0=>snare.pos;
                .25::T=>now;
                0=>snare.pos;
                .25::T=>now;
            }
            else
            {
                0=>hihat.pos;
                0=>tom.pos;
                .25::T=>now;
                0=>tom.pos;
                .25::T=>now;
            }
        }
    }

    public void connect(UGen ug)
    {
        gain => ug;
    }

    public void on(float g)
    {
        g => gain.gain;
    }

    public void off()
    {
        0 => gain.gain;
    }

    public void set_what_to_play(int p)
    {
        p => what_to_play;
    }

    public void set_T(dur t)
    {
        <<<"T: ", t/second>>>;
        t=>T;
    }
}
