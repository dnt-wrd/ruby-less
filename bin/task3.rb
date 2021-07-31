require_relative 'index.rb'
input = IO.read('files/input.txt')

def create_new_empty_file(f)
  if File.exists?(f)
    File.delete(f)
    file = File.new("files/results.txt", "a:UTF-8")
    file.close
  else
    file = File.new("files/results.txt", "a:UTF-8")
    file.close
  end
end

create_new_empty_file("files/results.txt")

### Создание массима хэшей для работы с данными
def create_list_students(input)
  input_array = input.split(" ")
  i = 0
  students = []

  while i <= input_array.size - 3
    student_hash = { :name => input_array[i], :lastname => input_array[i+1], :age => input_array[i+2].to_i}
    students << student_hash
    i = i + 3
  end
  return students
  file.close
end

### Считывание из консоли возраста и добавление его в массив
def save_student(age, array)
  students = []
  for a in array
    if age == a[:age]
    students << a
    end
  end
  return students
end


def read_age(age, array)
  arr = []

  if !arr.include?(age)
    arr << age
    save_student(age, array)
  end
end

def write_to_file(array)
  for a in array
    File.open("files/results.txt", "a") do |file|
      file.print "#{a[:name]} #{a[:lastname]} #{a[:age]}\n"
      file.close
    end
  end
end

students_age = []
students = create_list_students(input)
for s in students
  students_age << s[:age]
end

loop do
  puts "Введите возраст"
  age = input_error(gets.chop)
  if students_age.include? age
    write_to_file(save_student(age, create_list_students(input)))
    students_age.delete(age)
  end
  break if age == -1 || students_age == []
end

results_txt = create_list_students(IO.read('files/results.txt'))

for r in results_txt
  puts "#{r[:name]} #{r[:lastname]} #{r[:age]}"
end