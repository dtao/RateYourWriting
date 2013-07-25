module SubmissionsHelper
  def submissions_table(options=nil)
    options ||= {}
    render(:partial => 'submissions/table', :locals => {
      :without => options[:without] || []
    })
  end

  def submission_body(submission)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @markdown.render(submission.body)
  end
end
