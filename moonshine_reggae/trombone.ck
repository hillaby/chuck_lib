public class Trombone
{
    ABSndBuf trombone[1];
    Pan2 pans[1];
    /*LPF lpf=>*/Gain dummy=>pans[0];
    dummy=>Echo echo=>Gain feedback=>dummy;
    trombone[0].connect(dummy);
    trombone[0].set_gain(.8);
    // trombone[0].read("Trombone4.wav", 41);
    trombone[0].read("Trombone4.wav", 41.09);
    trombone[0].set_start_pos(6000);

    pans[0].left => Gain gainLeft;
    pans[0].right => Gain gainRight;

    (1.0/8.0)::AATimer.get_T() => echo.delay;
    .2 => echo.mix;
    1::AATimer.get_T() => echo.max;
    .9 => feedback.gain;


    //1200=>lpf.freq;
    //6000=>lpf.freq;

    pans[0].pan(0);

    off();
    spork ~ play();

    0=>int what_to_play;

    public void trb_note(float n1, float d)
    {
        trombone[0].note(n1, d);
    }

    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                trb_note(39, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(-1, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(36, .25);
                trb_note(39, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trombone[0].gliss(41, 43, .25);
                trb_note(-1, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(36, .25);
                trb_note(39, 2);
                trb_note(-1, 2);

                trb_note(39, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(-1, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(36, .25);
                trb_note(39, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trombone[0].gliss(41, 43, .25);
                trb_note(-1, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(36, .25);
                trb_note(39, 2);
                trb_note(-1, 2);

                trb_note(39, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(-1, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(36, .25);
                trb_note(39, .25);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(-1, .25);
                trombone[0].gliss(43, 44, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(40.9, 2);

                trb_note(-1, .75);
                trb_note(41, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(-1, .25);
                trb_note(41, .25);
                trb_note(40, 2);

                trb_note(-1, .75);
                trb_note(40, .25);
                trb_note(-1, .25);
                trombone[0].gliss(40, 41, .25);
                trb_note(-1, .25);
                trb_note(40, .25);
                trb_note(38, 2);

                trb_note(-1, 2);



                trb_note(36, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(40, .25);
                trb_note(-1, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(33, .25);
                trb_note(36, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trombone[0].gliss(38, 40, .25);
                trb_note(-1, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(33, .25);
                trb_note(36, 2);
                trb_note(-1, 2);

                trb_note(36, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(40, .25);
                trb_note(-1, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(33, .25);
                trb_note(36, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trombone[0].gliss(38, 40, .25);
                trb_note(-1, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(33, .25);
                trb_note(36, 2);
                trb_note(-1, 2);

                trb_note(36, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(40, .25);
                trb_note(-1, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(33, .25);
                trb_note(36, .25);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(40, .25);
                trb_note(-1, .25);
                trombone[0].gliss(40, 41, .25);
                trb_note(-1, .25);
                trb_note(40, .25);
                trb_note(38, 2);

                trb_note(-1, .75);
                trb_note(38, .25);
                trb_note(-1, .25);
                trb_note(39, .25);
                trb_note(-1, .25);
                trb_note(38, .25);
                trb_note(36, 2);

                trb_note(-1, .75);
                trb_note(43, .25);
                trb_note(-1, .25);
                trombone[0].gliss(43, 44, .25);
                trb_note(-1, .25);
                trb_note(43, .25);
                trb_note(41, 2);

                trb_note(-1, 2);
                /*
                trb_note(-1, 1.75);
                trombone[0].gliss(42, 43, .5);
                trb_note(47, .5);
                trombone[0].gliss(43, 44, .5);
                trb_note(48, .75);*/
            }
        }
    }

    public void connectLeft(UGen ug)
    {
        gainLeft => ug;
    }

    public void connectRight(UGen ug)
    {
        gainRight => ug;
    }

    public void on(float g)
    {
        g => gainLeft.gain;
        g => gainRight.gain;
    }

    public void off()
    {
        0 => gainLeft.gain;
        0 => gainRight.gain;
    }

    public void set_what_to_play(int p)
    {
        p => what_to_play;
    }
}
