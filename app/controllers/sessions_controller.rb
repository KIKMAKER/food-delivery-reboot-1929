require_relative '../views/session_view'
class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  def login
    # ask for a username (VIEW)
    username = @session_view.ask_for("username")
    # ask for a password (VIEW)
    password = @session_view.ask_for("password")
    # get the employee from the db based on the username
    employee = @employee_repository.find_by_username(username)
    # check if the password matches
    if employee && employee.password == password
      # if yes - print a success message
      @session_view.success_message
      return employee
    else
      # else try again
      @session_view.wrong_credentials
      login
    end
  end
end
