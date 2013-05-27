OvsmLib.play_list_from_html5_album = ( db_post_id ) ->
	play_list = []
	audio_album = $("audio_album#album#{db_post_id}")
	audio_album.find("audio_file").each( (i,e) ->
		play_list_entry =
			title: $(e).data('name')
			mp3: $(e).data('url')
		play_list.push( play_list_entry )
	)
	play_list
