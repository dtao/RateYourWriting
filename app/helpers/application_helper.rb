module ApplicationHelper
  def alert(notice)
    render(:partial => 'layouts/alert', :locals => notice)
  end
end
