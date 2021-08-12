require 'socket'
require 'rack'
require 'rack/utils'

server = TCPServer.new('0.0.0.0', 3000)

$ser = server
#$defaultBalance = 100.0 #delme
#$balance = 0 #delme

class CashMachine
  START_BALANCE = 100.0
  def initialize
    require_relative 'index.rb'
    path = "files/balance.txt"

    $balance = 0

    if File.exist?(path)
      $balance = IO.read(path).to_f
    else
      $balance  = START_BALANCE

    end
  end

  def deposit(input)
    #connection = server.accept
    #print connection
    #print "test"
    if input.to_f > 0 || input == ' '
      result =  $balance + input.to_f
      $balance = result
    else
      result = "Введено неверное значение"
    end

    return result
  end

  def withdraw(input)

    if input.to_f < 0
      result = "Сумма не может быть меньше 0"
    elsif input.to_f > $balance
      result = "Сумма не может больше баланса"
    else
      result = $balance - input.to_f
    end

    return  result

  end

  def balance
    return $balance
  end

  def save
    path = "files/balance.txt"

    File.open(path , "w") do |file|
      file.print($balance)
      file.close
    end
  end

end

$money = CashMachine.new

class App

  def call(env)
    req = Rack::Request.new(env)

    case req.path
    when '/deposit'
      [200, {'Content-Type' => 'text/html'}, [$money.deposit($input_sum)]]
    when '/withdraw'
      [200, {'Content-Type' => 'text/html'}, [$money.withdraw($input_sum)]]
    when '/balance'
      [200, {'Content-Type' => 'text/html'}, [$money.balance]]
    when '/save'
      [200, {'Content-Type' => 'text/html'}, [$money.save]]
    else
      [404, {'Content-Type' => 'text/html'}, ["Not found"]]
    end
  end
end

app = App.new

while connection = server.accept
  request = connection.gets
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]
  $input_sum = full_path.split('=')[1]

  status, headers, body = app.call({
                                     'REQUEST_METHOD' => method,
                                     'PATH_INFO' => path
                                   })

  connection.print("HTTP/1.1 #{status}\r\n")

  headers.each { |key, value|  connection.print("#{key}: #{value}\r\n") }

  connection.print "\r\n"

  body.each { |part| connection.print(part) }

  connection.close
end