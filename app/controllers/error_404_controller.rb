class Error404Controller < ApplicationController
  def not_found
    render status: 404
  end
end
