class OrderView

  def ask_for(something)
    puts "What is the #{something}'s number?"
    gets.chomp.to_i - 1
  end

  def display_list(riders)
    riders.each_with_index do |rider, index|
      puts "#{index + 1}. #{rider.username}"
    end
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.meal.name.capitalize} for #{order.customer.name} at #{order.customer.address}"
    end
  end

end
