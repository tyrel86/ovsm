module ApplicationHelper

	def icon_to_image( icon, color = "white" )
		icon.gsub!("_","-")
		icon += ("-" + color)
		image_tag icon + ".png"
	end

	def ovsm_optionify( model_array )
		model_array.inject([]) do |result,model|
			element = [ model.name, model.id ]
			result.push element
		end
	end

	def draw_on_off_stars( on = 3 )
		out = "<div class='star-container'>"
		on.times do
			out += "<div class='star-five on'></div>"
		end
		(3 - on).times do
			out += "<div class='star-five off'></div>"
		end
		out + "</div>"
	end
end
