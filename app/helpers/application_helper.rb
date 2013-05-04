module ApplicationHelper

	def icon_to_image( icon, color = "white" )
		icon.gsub!("_","-")
		icon += ("-" + color)
		image_tag icon + ".png"
	end
end
