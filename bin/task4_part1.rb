require_relative 'index.rb'
$path = "files/balance.txt"
START_BALANCE = 100.0
$balance = 0

if File.exist?($path )
  $balance = IO.read($path ).to_f
else
  $balance  = START_BALANCE
  file = File.new($path , "a:UTF-8")
  file.close
end

class CashMachine
  def error_in_input(a, operation)
    if a.to_f < 0 || a.to_i < 0 || a == "0" || a == "0.0"
      print "Значение должно быть больше 0, вы ввели #{a}\n\n"
      dep = true
    elsif a.to_f.to_s == a.to_s && a.to_s != "0.0"
      print "Возможно вы ввели символы(буквы) вместо числа(цифры)\n\n"
      dep = true
    elsif a.to_f == 0.0
      print "Возможно вы ввели символы(буквы) вместо числа(цифры)\n\n"
      dep = true
    elsif a.to_f >= $balance && operation == "withdraw"
      print "Сумма списания должна быть меньше или равна #{$balance}, а вы ввели #{a}\n\n"
      dep = true
    else
      return dep = false
    end
  end

  def deposit()
    print "Баланс = #{$balance}\nПожалуйста введите сумму депозита\n\n"
    input = gets.chop

    if !error_in_input(input, "deposit")
      $balance += input.to_f
    end

    print "Текущий баланс #{$balance}\n\n"
  end

  def withdraw()
    print "Баланс = #{$balance}\nПожалуйста введите сумму списания\n\n"
    input = gets.chop

    if !error_in_input(input, "withdraw")
      $balance -= input.to_f
    end

    print "Текущий баланс #{$balance}\n"
  end

  def quit(path)
    File.open(path , "w") do |file|
      file.print($balance)
      file.close
    end
  end

  def cm
    loop do
      print "D - deposit\nW - withdraw\nB - balance\nQ - quit\n\n"
      user_input = gets.chop.upcase

      case user_input
      when "D"
        deposit()
      when "W"
        withdraw()
      when "B"
        print "Текущий баланс #{$balance}\n\n"
      when "Q"
        quit($path )
      else
        print "Вводить можно только D, W, B, Q в верхнем или нижнем регистре\n\n"
      end
      break if user_input == "Q"
    end
  end

  def self.init
    CashMachine.new.cm
  end

end

a = CashMachine.new
a.init1
