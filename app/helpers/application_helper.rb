require 'digest/md5'

module ApplicationHelper
  def page_title
    [*content_for(:title), 'Rate Your Writing'].join(' - ')
  end

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

  def http_url(route)
    self.send(:"#{route}_url", :protocol => 'http', :host => Env::HTTP_HOST)
  end

  def login_url_for_env
    if Rails.env.production?
      login_url(:protocol => 'https', :host => Env::HTTPS_HOST)
    else
      login_path
    end
  end

  def register_url_for_env
    if Rails.env.production?
      register_url(:protocol => 'https', :host => Env::HTTPS_HOST)
    else
      register_path
    end
  end

  def markdown_editor(&content_block)
    render(:partial => 'layouts/markdown_editor', :locals => {
      :content => capture(&content_block)
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

    # compile URL
    image_tag("http://www.gravatar.com/avatar/#{hash}?s=50&d=identicon", options)
  end
end
