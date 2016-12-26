require 'pp'

# helper class for rms_rand_loop.ck
class RMSRandLoop
  
  # reads #{fname}.wav in and creates silence array in:
  #  silence_arr_#{fname}.ck
  # to be used in conjunction with rms_rand_loop.ck
  def self.analyze(fname)
	  puts "Analyzing wav files..."

	  puts "Analyzing #{fname}..."
	  File.open("tmp.ck","w") { |f|
		  f.puts "RMSRandLoop.analyze(\"#{fname}\");"
	  }

	  out = `chuck --silent "#{File.expand_path("../timer.ck", __FILE__)}" "#{File.expand_path("../rms_rand_loop.ck", __FILE__)}" tmp.ck 2>&1`
	  if $? != 0
		  pp out
		  raise
	  end

	  a = Hash.new
	  a[fname] = eval("["+out+"]")

	  print "Peak value is: "
	  max = 0
	  a[fname].each{ |x|
		  if (x[1] > max)
			  max = x[1]
		  end
	  }
	  puts max

	  silence_arr = []

	  ###
	  perct = 0.07
	  #perct = 0.04
	  #min_len = 3
	  min_len = 2
	  ###

	  cur_start_ind = -1
	  cur_last_ind = -1
	  # 0 - base
	  # 1 - inside silence
	  state = 0
	  0.upto(a[fname].length - 1) { |i|
		  if (a[fname][i][1] < max * perct)
			  if (state == 1)
				  cur_last_ind = i
			  else # 0
				  state = 1
				  cur_start_ind = i
				  cur_last_ind = i
			  end
		  elsif (state == 1)
			  state = 0
			  if (cur_last_ind-cur_start_ind+1 >= min_len)
				  silence_arr.push a[fname][cur_start_ind][0]
				  puts "From: #{a[fname][cur_start_ind][0]} len: #{cur_last_ind-cur_start_ind+1}"
			  end
		  end
	  }

	  if (state == 1)
		  if (cur_last_ind-cur_start_ind+1 >= min_len)
			  silence_arr.push a[fname][cur_start_ind][0]
			  puts "From: #{a[fname][cur_start_ind][0]} len: #{cur_last_ind-cur_start_ind+1}"
		  end
	  end

	  # generate silence arr in ck
	  File.open("silence_arr_#{fname}.ck","w") { |f|
		  f.puts "public class SA_#{fname} {"
		  f.puts "\tpublic static int[] get() {"
		  f.puts "\t\t[" + silence_arr.join(", ") + "] @=> int a[];"
		  #f.puts "\t\t<<<a[0]>>>;"
		  f.puts "\t\treturn a;"
		  f.puts "\t}"
		  f.puts "}"
	  }

	  pp silence_arr
	  #pp a
  end
  
end

