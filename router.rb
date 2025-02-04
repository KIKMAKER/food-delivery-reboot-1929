# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    puts "Welcome to Kiki's Delivery Service"
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
        # ask the user what they want to do
          display_manager_options
          # get their response
          user_action = gets.chomp.to_i
          # route to the correct controller action
          route_manager_action(user_action)
        else
          display_rider_options
          user_action = gets.chomp.to_i
          route_rider_action(user_action)
        end
      end
    end
  end

  def display_manager_options
    puts "What do you want to do?"
    puts "1 - add a meal"
    puts "2 - list all meals"
    puts "3 - add a customer"
    puts "4 - list all customers"
    puts "5 - MANAGER SPECIFIC THINGS"
    puts "8 - logout"
    puts "9 - quit"
  end

  def display_rider_options
    puts "What do you want to do?"
    puts "1 - RIDER SPECIFIC THINGS"
    puts "8 - logout"
    puts "9 - quit"
  end

  def route_manager_action(user_action)
    case user_action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then puts 'TODO'
    when 8 then logout
    when 9 then quit
    end

  end

  def route_rider_action(user_action)
    case user_action
    when 1 then puts "TODO"
    when 8 then logout
    when 9 then quit
    end

  end

  def logout
    @current_user = nil
  end

  def quit
    @running = false
    @current_user = nil
  end
end
