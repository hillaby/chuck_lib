// records everything to two separate tracks (left and right)
// usage:
// spork~Rec.rec("Name") @=> Shred aarec;
// ... keep on playing that funky music ...
// aarec.exit();

public class Rec
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
        //.74 => gleft.gain;
        //.74 => gright.gain;

        // infinite time loop...
        while( true ) 1::second => now;
    }

    public static void recMono(string filename)
    {
        dac => Gain g => WvOut w => blackhole;
        dac.right => Gain gright => WvOut wright => blackhole;
        (filename + ".wav") => w.wavFilename;
        <<<"writing to file:", "'" + filename + "'">>>;
        while( true ) 1::second => now;
    }
}
