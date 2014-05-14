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

	def index
		if params[:tag]
			@list = Video.tagged_with(params[:tag])
		else
			@list = Video.all
		end
	end

	def edit
    	@video = Video.find(params[:id])
  	end

	def update
		@video = Video.find(params[:id])
		if @video.update_attributes(video_params)
		  redirect_to @video, notice: "Updated video."
		else
		  render :edit
		end
	end

	private

	def video_params
		params.require(:video).permit(:name, :id, :url, :tag_list)
	end
end