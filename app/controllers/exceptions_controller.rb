class ExceptionsController < ApplicationController
  skip_before_action :check_xhr_header
  def redirect
    redirect(request.original_url)
  end
end
