class PortalSessionsController < ApplicationController

  def create
    binding.pry
    checkout_session_id = params[:session_id]
    checkout_session = Stripe::Checkout::Session.retrieve(checkout_session_id)

    # This is the URL to which users will be redirected after they are done
    # managing their billing.
    return_url = request.base_url
  
    session = Stripe::BillingPortal::Session.create(
      {
        customer: checkout_session.customer,
        return_url: return_url
      }
    )

    # TODO : make sure there isn't a better approach than `allow_other_host`
    redirect_to session.url, allow_other_host: true
  end

end