require 'rails/generators'

class DeviseFormtasticGenerator < Rails::Generators::Base
  desc "Copies formtastic enabled versions of Devise views to your application."
  
  argument :scope, :required => false, :default => nil,
                   :desc => "The scope to copy views to"
  
  def self.source_root
    File.expand_path("views", File.dirname(__FILE__))
  end

  def copy_views
    directory "devise", "app/views/#{scope || 'devise'}"
  end
end