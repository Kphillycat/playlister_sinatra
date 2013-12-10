class Song
	attr_accessor :genre, :artist, :name

	def genre=(genre)
		@genre = genre
		genre.songs << self
	end

	def self.song_page(user_choice)
	end

end