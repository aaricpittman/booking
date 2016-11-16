suffix = case Rails.env
when "development" then "_DEV"
when "test" then "_TEST"
end

Rails.configuration.stripe = {
  :publishable_key => ENV["PUBLISHABLE_KEY#{suffix}"],
  :secret_key      => ENV["SECRET_KEY#{suffix}"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
