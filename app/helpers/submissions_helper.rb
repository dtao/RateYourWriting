module SubmissionsHelper
  def submissions_table(options=nil)
    options ||= {}
    render(:partial => 'submissions/table', :locals => {
      :without => options[:without] || []
    })
  end

  def voting_section
    render(:partial => 'voting')
  end

  def comments_section
    render(:partial => 'comments')
  end
end
