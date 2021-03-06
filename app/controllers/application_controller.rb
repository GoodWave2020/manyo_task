class ApplicationController < ActionController::Base
  before_action :basic
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper
  private
  def basic
    if Rails.env == "production"
      authenticate_or_request_with_http_basic do |name, password|
            name == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end
end
