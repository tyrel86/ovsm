jQuery ->
	time_stamp = $("time_data").data("time")
	$(".digital_clock").clock({"timestamp":time_stamp,"calendar":"false"})
