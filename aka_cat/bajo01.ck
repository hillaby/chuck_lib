public class Bajo01
{
    //SinOsc osc => Gain gain;
    //SqrOsc osc => LPF lpf => Gain gain;
    //Moog osc => LPF lpf => Gain gain;
    Moog osc => Gain gain;
    SinOsc sosc => gain;
    
    /*
    .5 => osc.modDepth;	
    .5 => osc.modSpeed;	
    .5 => osc.filterQ;	
    .5 => osc.filterSweepRate;	
    */
    
    //1000 => lpf.freq;
    
       
    off();
    spork ~ play();
    
    
    public void play()
    {
        while(true)
        {
            1 => osc.gain; 
            .8 => sosc.gain; 
            Std.mtof(31.0) => osc.freq;
            Std.mtof(31.0) => sosc.freq;
            .8 => osc.noteOn;
            .5 => AATimer.advance;
            
            .8 => osc.gain; 
            .5 => sosc.gain; 
            
            .8 => osc.noteOn;
            Std.mtof(38.0) => osc.freq;
            Std.mtof(38.0) => sosc.freq;

            // advance time
            .25 => AATimer.advance;

            Std.mtof(43.0) => osc.freq;  
            Std.mtof(43.0) => sosc.freq;  
              
            .25 => AATimer.advance;
            
             0 => osc.gain;
             0 => sosc.gain;
            .5 => AATimer.advance;
            
            .8 => osc.noteOn;
            .8 => osc.gain; 
            .5 => sosc.gain; 
            
            Std.mtof(36.0) => osc.freq;
            Std.mtof(36.0) => sosc.freq;

            // advance time
            .25 => AATimer.advance;

            Std.mtof(41.0) => osc.freq;  
            Std.mtof(41.0) => sosc.freq;  
            .25 => AATimer.advance;           
        }            
    }
    
    public void connect(UGen ug)
    {
        gain => ug;
    }
    
    public UGen get()
    {
        return gain;
    }
    
    public void on(float g)
    {
        g => gain.gain;
    }
    
    public void off()
    {
        0 => gain.gain;
    }
}
