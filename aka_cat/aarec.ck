// chuck this with other shreds to record to file
// example> chuck foo.ck bar.ck rec (see also rec2.ck)

// arguments: rec:<filename>

public class AARec
{

    public static void rec(string filename)
    {
        // get name
        // pull samples from the dac
        dac.left => Gain gleft => WvOut wleft => blackhole;
        dac.right => Gain gright => WvOut wright => blackhole;
        // this is the output file name
        
        (filename + "_left.wav") => wleft.wavFilename;
        (filename + "_right.wav") => wright.wavFilename;
        <<<"writing to file:", "'" + filename + "'">>>;
        // any gain you want for the output
        .74 => gleft.gain;
        .74 => gright.gain;

        // infinite time loop...
        // ctrl-c will stop it, or modify to desired duration
        while( true ) 1::second => now;
    }

}