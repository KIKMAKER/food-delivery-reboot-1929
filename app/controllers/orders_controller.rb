require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/order_view'
require_relative '../models/order'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @order_view = OrderView.new
  end

  def add
    # get all the meals (MEAL REPO)
    meals = @meal_repository.all
    # ask for meal index
    @meal_view.display_list(meals)
    meal_index = @order_view.ask_for("meal")
    # get meal from meal array
    meal = meals[meal_index]

    # get all the customers (CUSTOMER REPO)
    customers = @customer_repository.all
    # ask for customer index
    @customer_view.display_list(customers)
    customer_index = @order_view.ask_for("customer")
    # get customer from customer array
    customer = customers[customer_index]

    # ask for rider index
    all_riders = @employee_repository.all_riders
    # get rider from employee array
    @order_view.display_list(all_riders)
    rider_index = @order_view.ask_for("rider")
    rider = all_riders[rider_index]

    # make the order
    order = Order.new(meal: meal, customer: customer, employee: rider)
    # send to repo
    @order_repository.create(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @order_view.display(undelivered_orders)
  end

  def mark_as_delivered(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @order_view.display(orders)
    order_index = @order_view.ask_for("order")
    my_orders = @order_repository.my_undelivered_orders(current_user)
    order = my_orders[order_index]
    @order_repository.mark_as_delivered(order)
  end

  def list_my_orders(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @order_view.display(orders)
  end

end
