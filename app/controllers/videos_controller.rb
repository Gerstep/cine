class VideosController < ApplicationController
	skip_authorization_check
 	skip_before_action :authenticate_user!

	def show
		embedly_api = Embedly::API.new :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
		url = Video.find(params[:id]).url
		metadata = embedly_api.oembed(
			:url => url,
			:maxwidth => 400)
		@obj = metadata[0].marshal_dump
	end

	def index
		require 'themoviedb'

		Tmdb::Api.key("0a543e78ddb43ca6a4366546c4a71850")
		@response = Tmdb::Movie.popular
		@url = Tmdb::Configuration.new.base_url

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