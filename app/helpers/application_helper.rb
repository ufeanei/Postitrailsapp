module ApplicationHelper
  def display_time(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
  
end
