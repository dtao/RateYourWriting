# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

RateYourWriting::Application.load_tasks

def read_file(*args)
  return File.read(File.join(__dir__, *args))
end

def write_file(*args)
  content = args.pop
  File.open(File.join(__dir__, *args), 'w') do |f|
    f.write(content)
  end
end

namespace :gen do
  desc "Generate a SASS file for every theme"
  task :themes => :environment do
    template = read_file('config', 'templates', 'theme.mustache')
    UserPreferences::THEMES.each do |theme|
      sass = Mustache.render(template, :theme => theme)
      file_name = "#{theme}.css.sass"
      write_file('app', 'assets', 'stylesheets', file_name, sass)
      puts "Generated #{file_name}."
    end
  end
end
