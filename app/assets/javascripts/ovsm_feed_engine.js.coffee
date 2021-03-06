jQuery ->
	class EndlessFeed

		constructor: ->
			@requests = 0
			@uri
			@uri_params =
				feed: null
				user: null
				luggage: null
				promotional: false
				category: null
				content_type: null
				last_post_time_stamp: null
			@json_data = {}

		api_uri: ->
			uri = "/posts.json?"
			for key, value of @uri_params
				uri += "&" unless key == "feed" or value == null or key == "user"
				uri += "#{key}=#{value}" unless value == null
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
			
		update_suitcase: (id) ->
			$(".post_thumb[data-post-id=#{id}]").find(".add_to_luggage").addClass("added")

		update_suitcases: ->
			data = $.ajax(
				dataType: "json"
				url: "/suitcases/post_ids_for_current_user"
				context: @
				success: (data) ->
					unless data["post_ids"] == "N/A"
						@update_suitcase(id) for id in data["post_ids"]
					if data["post_ids"] == "N/A"
						$(".add_to_luggage").hide()
			)

		suitcase_click_listeners: ->
			$(".add_to_luggage").unbind('click').click( ->
				event.stopPropagation()
				if $(this).hasClass("added")
					$.ajax( "/suitcases/1/remove_post/#{$(this).data('post-id')}")
					$(this).removeClass("added")
				else
					$.ajax( "/suitcases/1/add_post/#{$(this).data('post-id')}")
					$(this).addClass("added")
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
					@update_suitcases()
					@suitcase_click_listeners()
				)

		post_view_model: (post) ->
			@discover_content_types = (post) ->
				content_types = {}
				unless post.promotional
					content_types.is_user = true
					content_types.has_text = ((post.content != "") ? true : false)
					content_types.has_photos = ((post.photo_album.square_photos[0] != undefined) ? true : false)
					content_types.has_audio = ((post.audio_album.audio_files[0] != undefined) ? true : false)
					content_types.has_links = ((post.page_links[0] != undefined) ? true : false)
					content_types.has_video = ((post.video_album.video_files[0] != undefined) ? true : false)
				else
					content_types.is_business = true
				@content_types = content_types
			@discover_thumb_style = (ct, post) ->
				unless ct.is_business
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
				else
					return post.promo_type
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
				promo_type: post.promo_type
				content: post.content,
				exerpt: post.exerpt,
				content_types: @discover_content_types(post),
				has_content_type: (key) ->
					@content_types[key]
				thumb_style: @discover_thumb_style(@content_types, post)
				videos: @videos(post)
				photos: @photos(post)
				audio: @audio(post)
				links: post.page_links
				id: post.id
				user: post.user
				business: post.business
				promotional: post.promotional
				promo_price: post.promo_price
				promo_discounted_price: post.promo_discounted_price
				promo_description: post.promo_description
				promo_street_address: post. promo_street_address
				promo_city: post.promo_city
				promo_state: post.promo_state
				promo_zip: post.promo_zip
				promo_start_date: post.promo_start_date
				promo_end_date: post.promo_end_date
				promo_labor_characteristic: post.promo_labor_characteristic
				promo_free: post.promo_free
				promo_wage: post.promo_wage
				promo_wage_time: post.promo_wage_time
				promo_shipping_cost: post.promo_shipping_cost
				promo_href: post.promo_href
				promo_image: post.promo_image
				promo_name: post.promo_name
				location_type: post.location_type
				promo_contact_email: post.promo_contact_email
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
				if OvsmLib.feed.uri_params.user == null
					$(element).addClass("last") if (index + 1) % 4 == 0 and index != 0
				else
					$(element).addClass("last") if (index + 1) % 3 == 0 and index != 0
			)

		bind_post_expanders: ->
			$(".post_thumb_footer").unbind('click')
			$(".post_thumb_footer").click( ->
				$(this).parent().find("a.post-thumb-ajax-modal").modal(
					modalClass: "post-show modal"
				)
			)

		draw_feed: ->
			ko.applyBindings(@new_post_view_model_array_from_json())
			console.log @uri_params
			@reset_css_classes()
			@bind_post_expanders()

	unless $("feed_data").size() == 0 and $("user_feed").size() == 0
		OvsmLib.feed = new EndlessFeed
		OvsmLib.feed.uri_params.feed = $("feed_data").first().data('id') if $("feed_data").size() > 0
		OvsmLib.feed.uri_params.user = $("user_feed").first().data('user-id') if $("user_feed").size() > 0
		OvsmLib.feed.get_json_data()

		$(".post_type").click ->
			$(".post_type.active").removeClass("active")
			$(this).addClass("active")
			content_type = $(this).data("type")
			content_type = null if content_type == "all"
			OvsmLib.feed.uri_params.content_type = content_type
			OvsmLib.feed.get_json_data()

		$("#post_categories_select").change ->
			category_id = $(this).val()
			if category_id == "All Categories"
				OvsmLib.feed.uri_params.category = null
			else
				OvsmLib.feed.uri_params.category = category_id
			OvsmLib.feed.get_json_data()

		$(".luggage_toggle").click( ->
			if OvsmLib.feed.uri_params.luggage == null
				$(this).find('img').attr('src', "/assets/luggage_added.png")
				OvsmLib.feed.uri_params.luggage = true
			else
				$(this).find('img').attr('src', "/assets/luggage_not_added.png")
				OvsmLib.feed.uri_params.luggage = null
			OvsmLib.feed.get_json_data()
		)

		$(".tl_select").click( ->
			$(".tl_select.active").removeClass("active")
			$(this).addClass("active")
			if $(this).hasClass("businesses")
				OvsmLib.feed.uri_params.promotional = true
				$(".categories.people").hide()
				$(".categories.businesses").show()
				$(".link.post_type[data-type='all']").last().click()
			else
				OvsmLib.feed.uri_params.promotional = false
				$(".categories.people").show()
				$(".categories.businesses").hide()
				$(".link.post_type[data-type='all']").first().click()
		)
