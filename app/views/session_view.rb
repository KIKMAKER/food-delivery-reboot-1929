class SessionView
  def ask_for(something)
    puts "What is your #{something}?"
    gets.chomp
  end

  def success_message
    puts "You are now logged in!"
  end

  def wrong_credentials
    puts "Incorrect username or password please try again."
  end
end
