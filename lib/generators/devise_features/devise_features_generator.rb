require 'rails/generators'

class DeviseFeaturesGenerator < Rails::Generators::Base
  desc "Creates cucumber features for devise"
  
  argument :model, :required => true, :desc => "The devise model to create features for"
  
  def self.source_root
    File.expand_path("templates", File.dirname(__FILE__))
  end

  def copy_step_definitions
    directory "features/step_definitions", "features/step_definitions"
  end
  
  def copy_features
    template "features/authenticable_sign_in.feature", "features/#{model.downcase}_sign_in.feature"

    if Kernel.const_get(model).included_modules.include?(Devise::Models::Registerable)
      template "features/authenticable_sign_up.feature", "features/#{model.downcase}_sign_up.feature"
    end
    
    if Kernel.const_get(model).included_modules.include?(Devise::Models::Recoverable)
      template "features/authenticable_password_reset.feature", "features/#{model.downcase}_password_reset.feature"
    end
    
    # TODO: Handle Devise::Models::Confirmable and maybe others
    puts "You may need to edit the factories and define some paths in features/env/paths.rb"
    puts "
when /the (.+?) sign in page/
  send(\"new_\#{$1}_session_path\")
when /the (.+?) sign up page/
  send(\"new_\#{$1}_registration_path\")"
  end
end