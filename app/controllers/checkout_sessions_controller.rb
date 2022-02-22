class CheckoutSessionsController < ApplicationController

  def create
    prices = Stripe::Price.list(
      lookup_keys: [params['lookup_key']],
      expand: ['data.product']
    )

    begin
      session = Stripe::Checkout::Session.create({
        mode: 'subscription',
        line_items: [{
          quantity: 1,
          price: prices.data[0].id
        }],
        success_url: request.base_url + '/success.html?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: request.base_url + '/cancel.html',
      })
    rescue StandardError => e
      render json: {
        status: 'error',
        code: 4000,
        message: e.error.message
      }
    end

    # TODO : make sure there isn't a better approach than `allow_other_host`
    redirect_to session.url, allow_other_host: true
  end

end