OvsmLib.video_play_list_from_html5_album = ( db_post_id ) ->
	play_list = []
	video_album = $("video_album#album#{db_post_id}")
	video_album.find("video_file").each( (i,e) ->
		play_list_entry = [
			{ mp4: $(e).data('mp4_url') },
			{ ogg: $(e).data('ogv_url') },
			{ webm: $(e).data('webm_url') }
		]
		play_list.push( play_list_entry )
	)
	play_list
