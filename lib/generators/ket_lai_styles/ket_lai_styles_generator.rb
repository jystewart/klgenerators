require 'rails/generators'

class KetLaiStylesGenerator < Rails::Generators::Base
  desc "Applies Ket Lai's standard CSS"
  
  def copy_css
    template "core.css", "public/stylesheets/core.css"
  end
  
  def copy_images
    template "background.png", "public/stylesheets/background.png"
  end
end