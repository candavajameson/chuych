class SubscribeController < ApplicationController

  def index
  end

  def create
    @list_id = ENV['MAILCHIMP_LIST_ID']
    @subscrition = Gibbon::API.new
    @subscrition.lists.subscribe({
      id: @list_id,
      email: { email: subscribe_params[:email] }, :double_optin => true })

    flash[:notice] = "Subscription confirmation has been sent to your email"
    redirect_to_back
  rescue Gibbon::MailChimpError => e
    return redirect_to root_path, :flash => { error: e.message }
  end

private
  def subscribe_params
    params.require(:subscription_form).permit(:email)
  end

end
