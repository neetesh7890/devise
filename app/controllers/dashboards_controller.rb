class DashboardsController < ApplicationController

  def index
    @contacts = request.env['omnicontacts.contacts']
  end

  # def contact_callback
  #   @contacts = request.env['omnicontacts.contacts']
  #   @user = request.env['omnicontacts.user']
  #   puts "List of contacts of #{@user[:name]} obtained from #{params[:importer]}:"
  #   @contacts.each do |contact|
  #     puts "Contact found: name => #{contact[:name]}, email => #{contact[:email]}"
  #   end
  # end

  def failure
  end

end
