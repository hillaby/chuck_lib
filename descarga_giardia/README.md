This song will randomly combine different parts of improvised loops while
maintaining (or trying to maintain) musicality.

Just type
```
ruby rms_test.rb gen
```
to generate the silence array, and play the music. When the silence array has been generated, the music
can be directly played by typing
```
ruby rms_test.rb
```

You can change the output device by specifying a `--dac(N)` parameter. See
http://chuck.cs.princeton.edu/doc/program/vm.html.
