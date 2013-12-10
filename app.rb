require 'bundle'
require './lib/playlister'
Bundler.require

module playlist
	class App < Sinatra::Application
		get '/' do
			
		end

		get '/:choice' do
			@playlister = Playlister.new
			erb :list_all
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