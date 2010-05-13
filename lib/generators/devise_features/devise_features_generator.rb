require 'rails/generators'

class DeviseFeaturesGenerator < Rails::Generators::Base
  desc "Creates cucumber features for devise"
  
  argument :model, :required => true, :desc => "The devise model to create features for"
  
  def self.source_root
    File.expand_path("templates", File.dirname(__FILE__))
  end

  def copy_step_definitions
    directory "features/step_definitions", "features"
  end
  
  def copy_features
    template "features/authenticable_sign_in.rb", "features/#{model.downcase}_sign_in.rb"

    if Kernel.const_get(model).included_modules.include?(Devise::Models::Registerable)
      template "features/authenticable_sign_up.rb", "features/#{model.downcase}_sign_up.rb"
    end
    
    # TODO: Handle Devise::Models::Confirmable, Devise::Models::Recoverable, and maybe others
    puts "You may need to define some paths in features/env/paths.rb"
  end
end