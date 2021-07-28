require_relative 'index.rb'

print "Скажи своё имя\n"
name = gets.chop.to_str

puts "Отлично #{name}!Теперь скажи свою фамилию\n"
last_name = gets.chop.to_str

print "Отлично #{name}! Теперь скажи свой возраст\n"
age = input_error(gets.chop)

def old(name, last_name)

  print "Привет, #{name} #{last_name}. Самое время заняться делом\n"

end

def not_old(name, last_name)

  print "Привет, #{name} #{last_name}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано\n"

end

def result(name, last_name, age)

  if $error_age
    print "Error in age\n"
  else
    age.to_i > 18 && !$error_age ? old(name, last_name) : not_old(name, last_name)
  end

end

result(name, last_name, age)