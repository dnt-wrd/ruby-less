module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = ["post1", "post2", "post3"]
  end

  def index
    @posts.each_with_index do |post, index|
      print "#{index}. #{post}\n"
    end
  end

  def show
    print "Номер поста\n"
    input_index = gets.chomp.to_i

    if input_index < @posts.length
      print "#{@posts[input_index]}\n"
    else
      print "Неверный номер поста #{input_index }\n"

    end

  end

  def create
    print "Можете ввести пост\n"
    input_post = gets.chomp

    if input_post != ""
      @posts.push(input_post)
      print "#{@posts.length-1}. #{input_post}\n"
    else
      print "Пост не может быть пустым\n"
    end
  end

  def update
    print "Какой пост желаете отредактировать?\n"
    input_update_index = gets.chomp.to_i
    if input_update_index < @posts.length
      print "Можете ввести пост\n"
      input_update_post = gets.chomp
      if input_update_post != ""
        @posts[input_update_index] = input_update_post
        index
      else
        print "Пост не может быть пустым\n"
      end

    else
      print "Неверный номер поста #{input_update_index}\n"
    end

  end

  def destroy
    print "Какой пост желаете удалить?\n"
    input_delete_index = gets.chomp.to_i
    if input_delete_index < @posts.length
      @posts.delete_at(input_delete_index)
    else
      print "Неверный номер поста #{input_delete_index}\n"
    end
  end
end

class CommentsController < PostsController
  extend Resource

  def initialize
    @commemts = ["com1", "com2", "com3"]
  end

  def index
    @commemts .each_with_index do |comment, index|
      print "#{index}. #{comment}\n"
    end
  end

  def show
    print "Номер комментария\n"
    input_index = gets.chomp.to_i

    if input_index < @commemts.length
      print "#{@commemts[input_index]}\n"
    else
      print "Неверный номер комментария #{input_index}\n"
    end
  end

  def create
    print "Можете ввести пост\n"
    input_post = gets.chomp

    if input_post != ""
      @commemts.push(input_post)
      print "#{@commemts.length-1}. #{input_post}\n"
    else
      print "Пост не может быть пустым\n"
    end
  end

  def update
    print "Какой комментарий желаете отредактировать?\n"
    input_update_index = gets.chomp.to_i
    if input_update_index < @posts.length
      print "Можете ввести комментарий\n"
      input_update_post = gets.chomp
      if input_update_post != ""
        @posts[input_update_index] = input_update_post
        index
      else
        print "Пост не может быть пустым\n"
      end

    else
      print "Неверный номер поста #{input_update_index}\n"
    end

  end

  def destroy
    print "Какой комментарий желаете удалить?\n"
    input_delete_index = gets.chomp.to_i
    if input_delete_index < @commemts.length
      @commemts.delete_at(input_delete_index)
    else
      print "Неверный номер поста #{input_delete_index}\n"
    end
  end

end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      #if choise == "1"
      #  PostsController.connection(@routes['posts'])
      #elsif choise == '2'
      #  CommentsController.connection(@routes['comments'])
      #end

      PostsController.connection(@routes['posts']) if choise == '1'
      CommentsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init