require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exist?(csv_file)
  end

  def create(customer)
    # assign the customer id
    customer.id = @next_id
    # add to the array
    @customers << customer
    # increment / update the next_id
    @next_id += 1
    # save_csv
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end


  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # data conversions
      row[:id] = row[:id].to_i
      customer = Customer.new(row)
      @customers << customer
    end
    # @next_id = @customers.any? ? @customers.last.id + 1 : 1
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
