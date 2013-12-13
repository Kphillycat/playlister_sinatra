class Song
	attr_accessor :genre, :artist, :name
	SONGS = Array.new
	def initialize
		SONGS << self
	end
	def genre=(genre)
		@genre = genre
		genre.songs << self
	end

	def self.check_for_song(song_name)
		SONGS.detect {|song| song.name == song_name}
	end

	def self.all
		SONGS
	end

end