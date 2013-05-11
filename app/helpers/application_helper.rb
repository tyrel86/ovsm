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
end
