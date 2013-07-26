module ApplicationHelper
  def navigation_menu
    render(:partial => 'layouts/navigation_menu')
  end

  def alert(notice)
    render(:partial => 'layouts/alert', :locals => notice)
  end

  def submit_link(text, field, value)
    link_to(text, 'javascript:void(0);', :'data-field' => field, :'data-submit' => value)
  end

  def to_markdown(text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {
      :disable_indented_code_blocks => true
    })

    @markdown.render(text)
  end

  def highlight(content, options=nil)
    options ||= {}

    if (!options.include?(:if) || options[:if])
      return %Q[<span class="highlight">#{html_escape(content)}</span>]
    end

    content
  end
end
