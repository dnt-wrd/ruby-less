require_relative 'index.rb'

def find_twenty(num)
  num == 20 ? "num1" : "num2"
end

def result(num1, num2)
  if num1 == 20 || num2 == 20
    print "Одно из чисел(#{find_twenty(num1)}) равно 20\n"
  else
    res = num1 + num2
    print "Так оба числа не равны 20 то вот их сумма >>#{res}<<\n"
  end
end

puts "Введите первое число, num1"

n1 = input_error(gets.chop)

puts "Введите второе число, num2"

n2 = input_error?(gets.chop)

result(n1, n2)