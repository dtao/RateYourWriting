module Env
  HTTP_HOST  = Rails.env.production? && 'rateyourwriting.net' || 'localhost:3000'
  HTTPS_HOST = Rails.env.production? && 'ryw.herokuapp.com' || 'localhost:8000'

  PRODUCTION_URL_OPTIONS = ActiveSupport::HashWithIndifferentAccess.new({
    :http => {
      :protocol => 'http',
      :host => 'rateyourwriting.net'
    },

    :https => {
      :protocol => 'https',
      :host => 'ryw.herokuapp.com'
    }
  })

  DEVELOPMENT_URL_OPTIONS = ActiveSupport::HashWithIndifferentAccess.new({
    :http => {
      :protocol => 'http',
      :host => 'localhost',
      :port => 3000
    },

    :https => {
      :protocol => 'http',
      :host => 'localhost',
      :port => 8000
    }
  })

  def self.url_options(protocol)
    self.const_get("#{Rails.env.upcase}_URL_OPTIONS")[protocol]
  end
end
