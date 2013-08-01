require 'digest/md5'

module ApplicationHelper
  def page_title
    [*content_for(:title), 'Rate Your Writing'].join(' - ')
  end

  def navigation_menu
    render(:partial => 'layouts/navigation_menu')
  end

  def inline_navigation_menu
    render(:partial => 'layouts/inline_navigation_menu')
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

    @markdown.render(text || '')
  end

  def highlight(content, options=nil)
    options ||= {}

    if (!options.include?(:if) || options[:if])
      return %Q[<span class="highlight">#{html_escape(content)}</span>]
    end

    content
  end

  def http_url(route, *args)
    url_with_protocol(route, 'http', *args)
  end

  def https_url(route, *args)
    url_with_protocol(route, 'https', *args)
  end

  def url_with_protocol(route, protocol, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    self.send(:"#{route}_url", *args, options.merge(Env.url_options(protocol)))
  end

  def markdown_editor(form_helper, field_name)
    render(:partial => 'layouts/markdown_editor', :locals => {
      :form_helper => form_helper,
      :field_name => field_name
    })
  end

  def markdown_editor_with_diff(form_helper, field_name)
    render(:partial => 'layouts/markdown_editor_with_diff', :locals => {
      :form_helper => form_helper,
      :field_name => field_name
    })
  end

  def markdown_editor_with_preview(&content_block)
    render(:partial => 'layouts/markdown_editor_with_preview', :locals => {
      :content => capture(&content_block)
    })
  end

  def diff_editor(content, original)
    render(:partial => 'layouts/diff_editor', :locals => {
      :content => content,
      :original => original
    })
  end

  # snagged directly from:
  # https://en.gravatar.com/site/implement/images/ruby/
  def user_image_tag(user, options={})
    # get the email and make lowercase
    email = user.email.downcase

    # create the md5 hash
    hash = Digest::MD5.hexdigest(email)

    # set the alt attribute to the user's name
    options = { :alt => user.name }.merge(options)

    size = options.delete(:size) || 50

    # compile URL
    image_tag("http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=identicon", options)
  end
end
