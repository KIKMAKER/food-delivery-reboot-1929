class Employee
  attr_reader :username, :password, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def rider?
    @role == 'rider'
  end

  def manager?
    @role == 'manager'
  end

end
