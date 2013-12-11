class Song
	attr_accessor :genre, :artist, :name
	ALL = Array.new
	def initialize
		ALL << self
	end
	def genre=(genre)
		@genre = genre
		genre.songs << self
	end

	def self.check_for_song(song_name)
		ALL.detect {|song| song.name == song_name}
	end

	def self.all
		ALL
	end

end