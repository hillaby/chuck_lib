public class Magic01
{
    SndBuf s => ADSR s_adsr => LPF lpf => HPF hpf => HPF hpf2 => Pan2 pan;
    pan.left => Gain gainLeft;
    pan.right => Gain gainRight;
    .9 => s.gain;
    s_adsr.set( .1::ms, 8::ms, .9, 100::ms ); 

    //0=>s.preset;
    "ukelele damped buzz pluck bright lo.wav" => s.read;

    1.0 => lpf.gain;
    //1.0 => lpf2.gain;
    //11000 => lpf2.freq;
    1.0 => hpf.gain;
    //5 => f.Q;
    
    500 => hpf2.freq;

    // scale (in semitones)
    [ 0, 2, 4, 5, 6 ] @=> int scale[];
    
    off();
    spork ~ play();
    spork ~ change_scale();
    
    float max_gain;

    public void play()
    {
        // infinite time loop
        float t;
        //SinOsc ss => gain;
        while( true )
        {
            // get note class
            scale[ Std.rand2(0,4) ] => float freq;
            // get the final freq    
            Std.mtof( 53.0 + (Std.rand2(0,1)*12 + freq) ) => float fr;
            Std.randf()*0.7=>pan.pan;
            /*
            .5=>ss.gain;
            fr=>ss.freq;
            1::second=>AATimer.advance;
            0=>ss.gain;*/
            fr/Std.mtof(60) => s.rate;
            // sweep the cutoff
            80 + (Math.sin(t * pi) * 50 => Std.fabs) => Std.mtof => lpf.freq;
            40 + (Math.sin(t * pi) * 50 => Std.fabs) => Std.mtof => hpf.freq;
            .125 +=> t; 
            //1.0 => s.pluck;
            0000=>s.pos;
            1 => s_adsr.keyOn;
            // advance time
            .125 => AATimer.advance;
            //100=>AATimer.advance;
        }
    }
    
    public void change_scale()
    {
        while( true )
        {
            //[ 2, 2, 2, 2, 2 ] @=> scale;
            0 => gainLeft.gain;
            0 => gainRight.gain;
            [ 2, 4, 5, 8, 9 ] @=> scale;
            max_gain => gainLeft.gain;
            max_gain => gainRight.gain;
            1 => AATimer.advance;
            //[ 0, 0, 0, 0, 0 ] @=> scale;
            0 => gainLeft.gain;
            0 => gainRight.gain;
            [ 0, 2, 4, 7, 9 ] @=> scale;
            max_gain => gainLeft.gain;
            max_gain => gainRight.gain;
            1 => AATimer.advance;
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
        g => max_gain;
        g => gainLeft.gain;
        g => gainRight.gain;
    }
    
    public void off()
    {
        0 => max_gain;
        0 => gainLeft.gain;
        0 => gainRight.gain;
    }
    
  
    public void sweep_in_func(float g)
    {
        for (0 => int i; i <= 1000; i++)
        {
            on(i / 1000.0 * g);
            (1.0/250.0) => AATimer.advance;
        }
    }
    
    public void sweep_in(float g)
    {
        spork ~ sweep_in_func(g);
    }
}
