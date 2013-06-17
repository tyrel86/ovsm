module PostHelper
	def active_show_link( post )
		return "video" if post.has_video?
		return "audio" if post.has_audio?
		return "photo" if post.has_photos?
		return "link"  if post.has_links?
	end

	def active_show_link?( link, post )
		active_show_link( post ) == link
	end

	def active_media_panel?( panel, post )
		active_show_link( post ) == panel
	end
end
