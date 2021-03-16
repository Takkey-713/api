class ExceptionsController < ApplicationController
  def redirect
    redirect(request.original_url)
  end
end
