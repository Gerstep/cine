class VideosController < ApplicationController
	skip_authorization_check
 	skip_before_action :authenticate_user!

	def show
		embedly_api = Embedly::API.new :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
		metadata = embedly_api.oembed(
			:url => 'http://www.youtube.com/watch?v=sPbJ4Z5D-n4&feature=topvideos',
			:maxwidth => 200)
		@obj = params[:id]
	end

	def list
		@list = Video.all
	end
end