require_relative '../views/meal_view'
require_relative '../models/meal'
class MealsController
  def initialize(meal_repository)
    @meal_view = MealView.new
    @meal_repository = meal_repository
  end

  def add
    # ask the user for the meal name (VIEW)
    name = @meal_view.ask_for_name
    # ask the user for the meal price (VIEW)
    price = @meal_view.ask_for_price
    # instantiate the new meal instance (MODEL)
    new_meal = Meal.new(name: name, price: price)
    # store it in the repository (REPO)
    @meal_repository.create(new_meal)
  end

  def list
    # get all the meals (REPO)
    meals = @meal_repository.all
    # display (VIEW)
    @meal_view.display_list(meals)
  end
end
