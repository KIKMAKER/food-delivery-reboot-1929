require_relative '../views/customer_view'
require_relative '../models/customer'
class CustomersController
  def initialize(customer_repository)
    @customer_view = CustomerView.new
    @customer_repository = customer_repository
  end

  def add
    # ask the user for the customer name (VIEW)
    name = @customer_view.ask_for_name
    # ask the user for the customer address (VIEW)
    address = @customer_view.ask_for_address
    # instantiate the new customer instance (MODEL)
    new_customer = Customer.new(name: name, address: address)
    # store it in the repository (REPO)
    @customer_repository.create(new_customer)
  end

  def list
    # get all the customers (REPO)
    customers = @customer_repository.all
    # display (VIEW)
    @customer_view.display_list(customers)
  end
end
