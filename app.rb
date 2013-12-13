require 'bundler'
require './lib/parser.rb'
require 'open-uri'
require 'json'
Bundler.require

module Playlist
	class App < Sinatra::Application
		Parser.new("./data")

		get '/' do
			erb :index
		end

		get '/:choice' do
			erb :list_all
		end

		get '/artist/:name' do
			@artist = Artist.check_for_artist(params[:name])
			erb :artist
		end

		get '/genre/:name' do
			@genre = Genre.check_for_genre(params[:name])
			erb :genre
		end

		get '/song/:name' do
			@song = Song.check_for_song(params[:name])
			@download = open("http://ws.spotify.com/search/1/track.json?q=#{URI::encode(@song.name + " " +@song.artist.name)}")
			@html = JSON.parse(@download.read)
			if @html["info"]["num_results"] == 0
				@html = nil
			else
			 	@spotify_url = @html["tracks"][0]["href"]
			 end
			erb :song
		end

		helpers do
			def intermediate_partial(template, locals=nil)
	          locals = locals.is_a?(Hash) ? locals : {template.to_sym => locals}
	          template = :"_#{template}"
	          erb template, {}, locals        
        	end

        	def adv_partial(template,locals=nil)
	          if template.is_a?(String) || template.is_a?(Symbol)
	            template = :"_#{template}"
	          else
	            locals=template
	            template = template.is_a?(Array) ? :"_#{template.first.class.to_s.downcase}" : :"_#{template.class.to_s.downcase}"
	          end
	          if locals.is_a?(Hash)
	            erb template, {}, locals      
	          elsif locals
	            locals=[locals] unless locals.respond_to?(:inject)
	            locals.inject([]) do |output,element|
	              output << erb(template,{},{template.to_s.delete("_").to_sym => element})
	            end.join("\n")
	          else 
	            erb template
	          end
        	end
		end
	end
end