require 'csv'
require_relative '../models/employee'
class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv if File.exist?(csv_file)
  end

  def all_riders
    # go through each employee and SELECT those with role == rider
    @employees.select do |employee|
      employee.rider?
    end
    # method returns an array of riders
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # convert the datatypes
      row[:id] = row[:id].to_i
      # create instance of employee (row is a hash-like object of attributes)
      employee = Employee.new(row)
      # push into the employees array
      @employees << employee
    end
  end
end
