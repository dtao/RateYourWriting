module SubmissionsHelper
  def submission_body(submission)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @markdown.render(submission.body)
  end
end
