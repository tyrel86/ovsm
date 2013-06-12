jQuery ->
	class EndlessFeed

		constructor: ->
			@requests = 0
			@uri
			@uri_params =
				feed: 1
				promotional: false
				category: null
				content_type: null
				last_post_time_stamp: null
			@json_data = {}

		api_uri: ->
			uri = "/posts.json?"
			for key, value of @uri_params
				uri += "&" unless key == "feed" or value == null
				uri += "#{key}=#{value}" unless value == null
			console.log uri
			uri

		photo_album_click_listeners: ->
			add_remove_buttons = (photo_album) ->
				current = photo_album.find(".slide.active")
				next = current.next(".slide")
				prev = current.prev(".slide")
				if next.size() > 0
					photo_album.find(".next").addClass("on")
				else
					photo_album.find(".next").removeClass("on")
				if prev.size() > 0
					photo_album.find(".previous").addClass("on")
				else
					photo_album.find(".previous").removeClass("on")
			$(".photo_album .next").unbind('click').click( ->
				parent = $(this).parent()
				current = parent.find(".slide.active")
				next = current.next(".slide")
				if next.size() > 0
					current.removeClass("active")
					next.addClass("active")
				add_remove_buttons(parent)
			)
			$(".photo_album .previous").unbind('click').click( ->
				parent = $(this).parent()
				current = parent.find(".slide.active")
				prev = current.prev(".slide")
				if prev.size() > 0
					current.removeClass("active")
					prev.addClass("active")
				add_remove_buttons(parent)
			)
			

		get_json_data: ->
			@json_data = $.ajax(
				dataType: "json"
				url: @api_uri()
				context: @
				success: ( data ) ->
					@requests += 1
					$.extend(@json_data, data)
					OvsmLib.data = @json_data
					@draw_feed()
					#Video
					$(".flowplayer").flowplayer(
						swf: "/assets/flash/flowplayer.swf"
					)
					$(".flowplayer-playlist").each( (i,e) ->
						db_post_id = $(e).data('postid')
						play_list = OvsmLib.video_play_list_from_html5_album( db_post_id )
						$(e).flowplayer({
							 rtmp: "rtmp://s3b78u0kbtx79q.cloudfront.net/cfx/st",
							 playlist: play_list
						})
					)
					#Photo
					@photo_album_click_listeners()
					#Audio
					$(".jp-audio").each( (i,e) ->
						db_post_id = $(e).data('postid')
						play_list = OvsmLib.play_list_from_html5_album( db_post_id )
						new jPlayerPlaylist({
							jPlayer: "#jquery_jplayer_#{db_post_id}",
							cssSelectorAncestor: "#jp_container_#{db_post_id}"
						}, play_list, {
							swfPath: "/assets",
							supplied: "oga, mp3",
							wmode: "window",
							smoothPlayBar: true,
							keyEnabled: true
						})
					)
				)

		post_view_model: (post) ->
			@discover_content_types = (post) ->
				content_types = {}
				content_types.has_text = ((post.content != "") ? true : false)
				content_types.has_photos = ((post.photo_album.square_photos[0] != undefined) ? true : false)
				content_types.has_audio = ((post.audio_album.audio_files[0] != undefined) ? true : false)
				content_types.has_links = ((post.page_links[0] != undefined) ? true : false)
				content_types.has_video = ((post.video_album.video_files[0] != undefined) ? true : false)
				@content_types = content_types
			@discover_thumb_style = (ct) ->
				if @uri_params.content_type == null
					return "video" if ct.has_video
					return "audio" if ct.has_audio
					return "photo" if ct.has_photos
					return "links" if ct.has_links
					return "text" if ct.has_text
				else
					type = @uri_params.content_type
					return "video" if type == "video"
					return "audio" if type == "audio"
					return "photo" if type == "photos"
					return "links" if type == "links"
					return "text" if type == "text"
			@discover_file_type = (file) ->
				parts = file.file.url.split(".")
				ext = parts[ parts.length - 1 ]
				OvsmLib.file_type_mappings[ext]
			@videos = (post) ->
				video_files = []
				for video_file in post.video_album.video_files
					video_files.push video_file
				video_files
			@photos = (post) ->
				square_photos = []
				for photo in post.photo_album.square_photos
					square_photos.push photo
				square_photos
			@audio = (post) ->
				audio_files = []
				for audio_file in post.audio_album.audio_files
					audio_files.push audio_file
				audio_files
			{
				content: post.content,
				exerpt: post.exerpt,
				content_types: @discover_content_types(post),
				has_content_type: (key) ->
					@content_types[key]
				thumb_style: @discover_thumb_style(@content_types)
				videos: @videos(post)
				photos: @photos(post)
				audio: @audio(post)
				links: post.page_links
				id: post.id
			}

		new_post_view_model_array_from_json: ->
			posts_array = []
			for post in @json_data.posts
				new_post = @post_view_model( post )
				new_post.first_video = new_post.videos[0]
				posts_array.push( new_post )
			OvsmLib.test_array = posts_array
			{ posts: ko.observableArray(posts_array) }

		reset_css_classes: ->
			$(".post_thumb").each( (index,element) ->
				$(element).removeClass("last")
				$(element).addClass("last") if (index + 1) % 4 == 0 and index != 0
			)

		draw_feed: ->
			ko.applyBindings(@new_post_view_model_array_from_json())
			@reset_css_classes()

	feed = new EndlessFeed
	feed.get_json_data()
	$(".post_type").click ->
		$(".post_type.active").removeClass("active")
		$(this).addClass("active")
		content_type = $(this).data("type")
		content_type = null if content_type == "all"
		feed.uri_params.content_type = content_type
		feed.get_json_data()

	$("#post_categories_select").change ->
		category_id = $(this).val()
		if category_id == "All Categories"
			feed.uri_params.category = null
		else
			feed.uri_params.category = category_id
		feed.get_json_data()
