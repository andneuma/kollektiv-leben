module Helpers
  def login
    session[:group_id] = group.id
  end

  def logout
    session[:group_id] = nil
  end
end
