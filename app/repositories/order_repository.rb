require 'csv'
require_relative '../models/order'
class OrderRepository
  def initialize(orders_csv_file, meal_repository, customer_repository, employee_repository)
    @orders_csv_file = orders_csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(orders_csv_file)
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }

    # @orders.select { |order| !order.delivered? }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  def my_undelivered_orders(current_user)
    @orders.select do |order|
      order.employee == current_user && !order.delivered?
    end
  end

  private

  def load_csv
    CSV.foreach(@orders_csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      # compare delivered to string true
      row[:delivered] = row[:delivered] == "true"
      # get the meal id and convert to integer
      meal_id = row[:meal_id].to_i
      # retrieve the meal instance from the meal repo using the id
      row[:meal] = @meal_repository.find(meal_id)

      customer_id = row[:customer_id].to_i
      row[:customer] = @customer_repository.find(customer_id)

      employee_id = row[:employee_id].to_i
      row[:employee] = @employee_repository.find(employee_id)

      order = Order.new(row)
      @orders << order
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@orders_csv_file, "wb") do |csv|
      csv << ["id", "delivered", "meal_id", "customer_id", "employee_id"]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end
