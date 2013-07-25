module ApplicationHelper
  def navigation_menu
    render(:partial => 'layouts/navigation_menu')
  end

  def alert(notice)
    render(:partial => 'layouts/alert', :locals => notice)
  end
end
