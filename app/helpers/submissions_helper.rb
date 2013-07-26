module SubmissionsHelper
  def submissions_table(options=nil)
    options ||= {}
    render(:partial => 'submissions/table', :locals => {
      :without => options[:without] || []
    })
  end

  def submission_body(submission)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {
      :disable_indented_code_blocks => true
    })

    @markdown.render(submission.body)
  end

  def voting_section
    render(:partial => 'voting')
  end

  def comments_section
    render(:partial => 'comments')
  end
end
