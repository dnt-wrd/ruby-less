require_relative 'index.rb'

puts "Сколько покемонов добавить?"
poke_count = input_error(gets.chop)

def create_array(n)

  arr = []
  i = 1
  while i <= n
    print "Как зовут покемона?\n"
    name_input = gets.chop.to_str

    print "Какого он цвета?\n"
    color_input = gets.to_str.chop

    pokemons = { "name" => name_input, "color" => color_input}

    arr << pokemons
    i+=1
  end
  return arr
end

print "#{create_array(poke_count)}\n"

#def result(array)
#  for a in array
#    print "#{a}\n"
#  end
#end

#result(create_array(poke_count))