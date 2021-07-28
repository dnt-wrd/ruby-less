def input_error(num)

  if num != num.to_i.to_s
    abort "Вводить можно только цифры"
  end
  return num.to_i

end