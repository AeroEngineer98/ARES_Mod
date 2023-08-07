


function movingSwitch(command, position, time_step, actuator_time) -- Requires the switch to actuate between 0 and 1, not -1 and 1
	local increment = time_step/actuator_time

	if (position < 1) and (command > 0) then
		position = position + increment
		--print_message_to_user("state 1")
	elseif (position > 0) and (command < 1) then
		position = position - increment
		--print_message_to_user("state 2")
	elseif (position == 0) and (command == 0) then
		position = 0
		--print_message_to_user("state 3")
	elseif (position == 1) and (command == 1) then
		position = 1
		--print_message_to_user("state 4")
	end
	
	return position
end




