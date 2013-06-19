jQuery ->
	if $("#map").size() > 0
		$("#map").css("height",$(window).height() - 100)

		map = L.map('map').setView([37, -90], 4)
		# map.fitBounds([[-90, -180],[90, 180]])

		cloud_made =
			api_key: 'b62a32b6ef034942be4b49e66bfe145f'
			style_id: '92877'
			tile_size: '256'
			minZoom: 3
			maxZoom: 4
			noWrap: true
			reuseTiles: true
		L.tileLayer('http://{s}.tile.cloudmade.com/{api_key}/{style_id}/256/{z}/{x}/{y}.png', cloud_made).addTo(map)

		open_weather =
			minZoom: 3
			maxZoom: 4
			opacity: 0.3
			noWrap: true
			reuseTiles: true
		L.tileLayer('http://{s}.tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png', open_weather).addTo(map)

		default_icon = L.icon(
			iconUrl: '/assets/feed_marker.png'
			iconSize: [25, 48]
			iconAnchor: [13, 46]
			popupAnchor: [0, -37]
		)

		draw_feed_markers_and_initilize_auto_complete = ->
			jQuery.getJSON '/feeds.json', (data) ->
				window.feeds = data.feeds
				for feed in window.feeds
					marker = L.marker([feed.lat, feed.lng],
						icon: default_icon
					).addTo(map)
					marker.bindPopup("<a href='/feeds/#{feed.slug}'>#{feed.name}</a>")

		draw_feed_markers_and_initilize_auto_complete()
