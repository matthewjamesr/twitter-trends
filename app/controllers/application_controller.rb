class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'date'

  time = Time.now.to_s
  time = DateTime.parse(time).strftime("%m/%d/%Y %H:%M")

  Mixpanel.track(time, "Visit")

  p time
end
