module Env
  HTTP_HOST = Rails.env.production? && 'rateyourwriting.net' || 'localhost:3000'
  HTTPS_HOST = Rails.env.production? && 'ryw.herokuapp.com' || 'localhost:3000'
end
