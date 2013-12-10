class Genre
	attr_accessor :name, :songs, :artists
	@@count = []

	def initialize
		@name
		@songs = []
		@artists = []
		@@count << self
	end	


	def self.all
		@@count
	end

	def self.reset_genres
		@@count.clear
	end


end