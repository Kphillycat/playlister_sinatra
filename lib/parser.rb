require_relative 'lib/artist'
require_relative 'lib/song'
require_relative 'lib/genre'

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

