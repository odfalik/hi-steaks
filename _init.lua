function _init()
	printh('start of game')
	-- seconds since pico-8 was started
	starttime = time()

	-- seconds since game start
	gametime = 0

	-- the lowest point the ufo can go
	lowlimit = 80

	-- flag that you cant go lower
	altitude_flag = false

	--how many cows have you sucked the spots out of
	score = 0

	--half the width of the abduction beam
	beam_half_width = 8

	--is the beam currently on
	beam_on = false

	player = {
		health = 3,
		speed = 1.5,
		x = 63,
		y = 63,
		fx = false,
		fy = false,
		sp = 1,
		--relative to top left of sprite--
		collider = {
			-- top left --
			x1 = 1,
			y1 = 3,
			-- bottom right --
			x2 = 6,
			y2 = 6
		},
		check_if_collider_hit = function(self, x, y)
			-- translate the relative player collider to screen space --
			local absolute_player_collider = {
				x1 = self.x + self.collider.x1,
				y1 = self.y + self.collider.y1,
				x2 = self.x + self.collider.x2,
				y2 = self.y + self.collider.y2
			}
			-- its between the top of the box and the bottom of the box.
			local is_between_top_and_bottom = y>absolute_player_collider.y1 and y<absolute_player_collider.y2
			--and its between the right and left
			local is_between_right_and_left = x>absolute_player_collider.x1 and x<absolute_player_collider.x2

			local is_in_box = is_between_top_and_bottom and is_between_right_and_left
			return is_in_box
		end
	}

	cows = {
		create_cow(),
		create_cow(),
		create_cow()
	}

	farmers = {
		create_farmer(),
		create_farmer()
	}
end

function is_in_beam(object)
	return object.x < player.x + beam_half_width and object.x > player.x - beam_half_width
end

