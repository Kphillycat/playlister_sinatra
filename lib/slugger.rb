Module Slugger
	def slug
		slugged_name = self.name
		replacements = [[" ","_"], [".","#"]]
		replacements.each {|replacement| slugged_name.gsub!(replacement[0],replacement[1])}	
		slugged_name	
	end
end