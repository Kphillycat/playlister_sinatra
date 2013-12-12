require './lib/artist'
require './lib/song'
require './lib/genre'
require 'json'

class Parser 

	def initialize(directory)
		files = Dir.entries(directory).delete_if{|str| str[0] == "."}
		files.each do |song|
			matches = /(?<artist>.*)\s-\s(?<song>.*)\s\[(?<genre>.*)\]/.match(song)
			artist = Artist.check_for_artist(matches[:artist]) || Artist.new.tap {|artist| artist.name = matches[:artist]}
			song = Song.new
			song.name = matches[:song]
			genre = Genre.check_for_genre(matches[:genre]) || Genre.new.tap {|genre| genre.name = matches[:genre]}
			song.genre = genre
			artist.add_song(song)
		end
	end

	def all_artists
		Artist.all
	end

	def all_genres
		Genre.all
	end
	def all_songs
		Song.all
	end

	def find_artist(name)
		Artist.check_for_artist(name)
	end

	def find_genre(name)
		Genre.check_for_genre(name)
	end

		def find_song(name)
		Song.check_for_song(name)
	end

	def to_link(name)
		name.gsub
	end
end

