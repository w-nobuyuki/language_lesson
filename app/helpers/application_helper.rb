module ApplicationHelper
  def h_active(target_path)
    return 'active' if request.path.include?(target_path)
  end
end
