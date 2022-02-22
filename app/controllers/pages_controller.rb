class PagesController < ApplicationController
  def subscription
  end

  def success
    binding.pry
    @checkout_session_id = params[:session_id]
  end

  def cancel
  end
end