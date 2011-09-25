# Load the rails application

require File.expand_path('../application', __FILE__)
# Paperclip.options[:command_path] = "/usr/bin/"
# config.gem 'paperclip', :source => 'http://rubygems.org'

# Initialize the rails application
Circl::Application.initialize!
