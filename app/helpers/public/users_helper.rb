module Public::UsersHelper

  def new_line(introduction)  #改行するため
    safe_join(introduction.split("\n"),tag(:br))
  end
end
