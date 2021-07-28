require_relative 'index.rb'

def end_CS(str)

  str_end = "CS"
  str_input_end = str[-2..]
  str_length = str.size

  if str_input_end == str_end
      print 2 ** str_length
  else
    str_rev = str.reverse
    print "#{str_rev}\n"
  end

end

puts "Введите число"
n = input_error(gets.chop)

puts "Введите слово"
word = gets.chop.to_str

end_CS(word)