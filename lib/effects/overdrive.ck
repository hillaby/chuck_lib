// an overdrive based on
// a distortion class taken
// from http://electro-music.com/forum/topic-19287-25.html
// credit due to kijjaz

public class Overdrive extends Effect {
    // this class calculate overdrive transfer function from this function:
    // f(x) = (a1x + b1x^2 + c1x^3) / (1 + |a2x| + b2x^2 + |c2x^3|)

    // to set a, b, c
    // use a1Init.next, b1Init.next, c1Init.next
    // and a1Init.next, b1Init.next, c1Init.next

    // or if you want to adjust a, b, c by multiplying with other signal,
    // chuck the signals to ax, bxx, cxxx (their .op's are all MULTIPLY in here)


    Step a1Init; a1Init.next(1); // initialize a1
    Step b1Init; b1Init.next(1); // initialize b1
    Step c1Init; c1Init.next(1); // initialize c1
    Step a2Init; a2Init.next(1); // initialize a2
    Step b2Init; b2Init.next(1); // initialize b2
    Step c2Init; c2Init.next(1); // initialize c2

    a1Init => Gain a1x; input => a1x; a1x.op(3); // calculate a1x
    b1Init => Gain b1xx; input => b1xx; input => Gain dummyB1 => b1xx; b1xx.op(3); // calculate b1x^2
    c1Init => Gain c1xxx; input => c1xxx; input => Gain dummyC1 => c1xxx; input => Gain dummyC2 => c1xxx;
    c1xxx.op(3); // calculate c1x^3

    Gain UPPER; // prepare the upper part of the division
    a1x => UPPER; b1xx => UPPER; c1xxx => UPPER; // calculate a1x + b1x^2 + c1x^3

    Step one; // prepare 1
    a2Init => Gain a2x; input => a2x; a2x.op(3); // calculate a2x
    b2Init => Gain b2xx; input => b2xx; input => Gain dummyB1_2 => b2xx; b2xx.op(3); // calculate b2x^2
    c2Init => Gain c2xxx; input => c2xxx; input => Gain dummyC1_2 => c2xxx; input => Gain dummyC2_2 => c2xxx;
    c2xxx.op(3); // calculate c2x^3

    a2x => Gain a2xANDc2xxx; c2xxx => a2xANDc2xxx; // calculate a2x + c2x^3
    a2xANDc2xxx => FullRect ABSa2xANDc2xxx; // calculate |a2x + c2x^3|

    Gain LOWER; // prepare the lower part of the division
    one => LOWER; b2xx => LOWER; ABSa2xANDc2xxx => LOWER; // calculate 1 + b2x^2 + |a2x + c2x^3|

    UPPER => output;
    LOWER => output;
    output.op(4); // calculate f(x) by dividing UPPER with LOWER

	public void coefs(float cfs[]) {
		this.a1Init.next(cfs[0]);
		this.b1Init.next(cfs[1]);
		this.c1Init.next(cfs[2]);
		this.a2Init.next(cfs[3]);
		this.b2Init.next(cfs[4]);
		this.c2Init.next(cfs[5]);
	}

	0 => int type;

	public void setType(int p) {
		if (p == 0) { // off
			coefs([1., 0., 0., 0., 0., 0.]);
		} else if (p == 1) { // abs
			coefs([1., 0., 0., 1., 0., 0.]);
		} else if (p == 2) { // ^2
			coefs([1., 1., 0., 0., 1., 0.]);
		} else if (p == 3) { // ^3
			coefs([1., 0., 1./*a*/, 1., 0., 1./*a*/]);
		}
		p => type;
	}

	public void drive(float drive) {
		Std.dbtopow(95. + 45.*drive)*drive=> float d;
		//<<<d>>>;
		if (type == 1) {/*
			1. => float xcoef;
			if (d > 1.) {
				d => xcoef;
			}*/
			1.+d => float xcoef;
			coefs([xcoef, 0., 0., d, 0., 0.]);
		} else if (type == 2) {
			coefs([1., d, 0., 0., d, 0.]);
		} else if (type == 3) {
			coefs([1., 0., d, 0., 0, d]);
		}
	}
}
