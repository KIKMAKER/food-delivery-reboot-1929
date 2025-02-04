class MealView

  def ask_for_name
    puts "What is the meal name?"
    gets.chomp
  end

  def ask_for_price
    puts "What is the meal price?"
    gets.chomp.to_i
  end

  def display_list(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name} --- R#{meal.price}"
    end
  end

end
