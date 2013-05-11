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
			uri

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
				)

		draw_feed: ->
			posts_array = []

			for post in @json_data.posts
				post_object =
					content: post.content
				posts_array.push( post_object )

			viewModel =
        posts: ko.observableArray(posts_array)
    	ko.applyBindings(viewModel)

	feed = new EndlessFeed
	feed.get_json_data()
