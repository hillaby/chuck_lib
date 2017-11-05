public class Piano
{
    Echo echoLeft => Gain gainLeft => Gain feedbackLeft => echoLeft;
    (1.0/8.0)::AATimer.get_T() => echoLeft.delay;
    .3 => echoLeft.mix;
    1::AATimer.get_T() => echoLeft.max;
    .7 => feedbackLeft.gain;
    
    Echo echoRight => Gain gainRight => Gain feedbackRight => echoRight;
    (1.0/8.0)::AATimer.get_T() => echoRight.delay;
    .3 => echoRight.mix;
    1::AATimer.get_T() => echoRight.max;
    .7 => feedbackRight.gain;
    
    Pan2 rightPan;
    rightPan.left => echoLeft;
    rightPan.right => echoRight;
    rightPan.pan(0.5);
    
    Pan2 leftPan;
    leftPan.left => echoLeft;
    leftPan.right => echoRight;
    leftPan.pan(-0.5); 
    
    SndBuf p => ADSR p_adsr => rightPan;
    "piano_D4.wav" =>  p.read;
    .5 => p.gain;
    p_adsr.set( .1::ms, 8::ms, .9, 100::ms ); 
    
    SndBuf p2 => ADSR p2_adsr => leftPan;
    "piano_D4.wav" =>  p2.read;
    .5 => p2.gain;
    p2_adsr.set( .1::ms, 8::ms, .9, 100::ms ); 
    SndBuf p3 => ADSR p3_adsr => rightPan;
    "piano_D4.wav" =>  p3.read;
    .5 => p3.gain;
    p3_adsr.set( .1::ms, 8::ms, .9, 100::ms ); 
    SndBuf p4 => ADSR p4_adsr => leftPan;
    "piano_D4.wav" =>  p4.read;
    .5 => p4.gain;
    p_adsr.set( .1::ms, 8::ms, .9, 100::ms ); 
    
  
    off();
    spork ~ play();
    
    public void chord(float n1, float n2, float n3, float n4, float d)
    {
        spork~note(p,p_adsr,n1,d);
        spork~note(p2,p2_adsr,n2,d);
        spork~note(p3,p3_adsr,n3,d);
        note(p4,p4_adsr,n4,d);
    }
    
    public void note(SndBuf p, ADSR p_adsr, float n, float d)
    {
        // 91 => g6
        Std.mtof(n)/Std.mtof(50) => p.rate;
        0=>p.pos;
        //0=>sax.pos;
        p_adsr.keyOn();
        .9*d => AATimer.advance;
        .1*d*AATimer.get_T() => p_adsr.releaseTime;
        p_adsr.keyOff();
        .1*d => AATimer.advance;
    }
    
    public void play()
    {
        while(true)
        {
            .25=>AATimer.advance;
            chord(48, 52, 55, 59, .125);
            .125=>AATimer.advance;
            .25=>AATimer.advance;
            chord(50, 54, 57, 60, .125);
            .125=>AATimer.advance;
            .25=>AATimer.advance;
            if (Std.randf() > -0.3)
            {
                chord(47, 50, 53, 55, .125);
            }
            else
            {
                chord(43, 47, 50, 53, .125);
            }
            .125=>AATimer.advance;
            .25=>AATimer.advance;
            chord(51, 55, 58, 62, .125);
            .125=>AATimer.advance;
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
}