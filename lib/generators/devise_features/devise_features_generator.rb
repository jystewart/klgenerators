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
    template "features/authenticable_sign_in.rb", "features/#{model.downcase}_sign_in.feature"

    if Kernel.const_get(model).included_modules.include?(Devise::Models::Registerable)
      template "features/authenticable_sign_up.rb", "features/#{model.downcase}_sign_up.feature"
    end
    
    if Kernel.const_get(model).included_modules.include?(Devise::Models::Recoverable)
      template "features/authenticable_password_reset.feature", "features/#{model.downcase}_password_reset.feature"
    end
    
    # TODO: Handle Devise::Models::Confirmable and maybe others
    puts "You may need to define some paths in features/env/paths.rb"
  end
end