class Song
	attr_accessor :name

	def initialize
		@name
		@genre
	end

	def genre=(new_genre)
		@genre = new_genre		
		new_genre.songs << self		
	end

	def genre
		@genre
	end
end