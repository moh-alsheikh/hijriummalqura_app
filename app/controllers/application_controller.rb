# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  #rescue_from ActionView::Template::Error do |exception|
  #  render 'public/500.html'
  #end
end
