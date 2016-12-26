// random low-pass filter
// Randomly changes freq. and Q.

public class RandLPF extends Effect 
{
	input => LPF lpf => output;
	20 => int minFreq;
	20000 => int maxFreq;
	maxFreq=>lpf.freq;
	4.5=>lpf.Q;
	1. => float minQ;
	8. => float maxQ;
	
	// sets minimum and maximum frequency
	public void setMinMax(int min, int max)
	{
		min => minFreq;
		max => maxFreq;
	}
	
	// sets min. and max. Q
	public void setMinMaxQ(float min, float max)
	{
		min => minQ;
		max => maxQ;
	}
	
	// changes frequency...
	public void changeFreq()
	{
		while (1)
		{
			Std.rand2(minFreq, maxFreq) => int nextFreq;
			nextFreq / lpf.freq() => float diff;
			//<<< "diff",diff >>>;
			Std.rand2f(50, 500) => float division;
			for (0 => int i; i < division; i++)
			{
				lpf.freq() * Math.pow(diff, 1./division) => lpf.freq;
				//<<< "l",diff,division,Math.pow(diff, 1./division),lpf.freq() >>>;
				100::samp=>now;
			}
		}
	}
	spork~changeFreq();
	
	// changes Q
	public void changeQ()
	{
		while (1)
		{
			Std.rand2f(minQ, maxQ) => float nextQ;
			nextQ - lpf.Q() => float diff;
			//<<< "diff",diff >>>;
			Std.rand2f(50, 500) => float division;
			for (0 => int i; i < division; i++)
			{
				lpf.Q() + diff/division => lpf.Q;
				//<<< "l",diff,division,Math.pow(diff, 1./division),lpf.freq() >>>;
				100::samp=>now;
			}
		}
	}
	spork~changeQ();
}
