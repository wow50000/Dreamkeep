var/global/total_spawned_mobs = 0
var/global/max_total_spawned_mobs = 100 // New global variable for the total limit

/obj/effect/mob_spawner
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	var/spawn_timer
	var/max_spawned_mobs = 1
	var/mobs_to_spawn = 0
	var/current_spawned_mobs = 0
	var/spawn_interval = 3600 //6 minutes
	var/temporary = FALSE
	var/spawn_range = 10 //radius in which mobs can be spawned
	var/player_range = 15 //range at which a nearby player will pause the spawner
	var/list/ambush_mobs = list(/mob/living/carbon/human/species/skeleton/npc/ambush = 20)
	var/list/adventurer_landmarks = list() // Store landmarks here
	var/area/valid_area = /area/rogue //Useful for randomly generated maps, will delete spawners created outside this area.
	var/turf/accepted_turf = /turf/open/floor/rogue

	New()
		..() // Call the parent constructor
		adventurer_landmarks = get_all_adventurer_landmarks() //prevents spawners from being placed near player spawns
		if (!is_in_valid_area(src))
			del src  // Delete the spawner if it's not in the valid area
		else
			start_spawning()

	proc/start_spawning()
		spawn_timer = addtimer(CALLBACK(src, .proc/spawn_and_continue), spawn_interval, TIMER_STOPPABLE)

	proc/spawn_and_continue()
		if (total_spawned_mobs < max_total_spawned_mobs && current_spawned_mobs < max_spawned_mobs)
			spawn_random_mobs(mobs_to_spawn)
		start_spawning()
		if (temporary)
			QDEL_IN(src, 30)
			return
	proc/spawn_random_mobs(var/num_to_spawn)
		var/spawn_chance = 100 // 100% chance to spawn if conditions are met
		if (prob(spawn_chance) && total_spawned_mobs < max_total_spawned_mobs)
			var/turf/spawn_turf
			var/mob_type
			var/mob/new_mob
			var/i = 0
			while (i < num_to_spawn && total_spawned_mobs < max_total_spawned_mobs)
				spawn_turf = get_random_valid_turf()
				if (spawn_turf)
					mob_type = pickweight(ambush_mobs)
					new_mob = new mob_type(spawn_turf)
					if (new_mob)
						current_spawned_mobs++
						total_spawned_mobs++
						RegisterSignal(new_mob, COMSIG_PARENT_QDELETING, .proc/on_mob_destroy)
				i++

	proc/get_random_valid_turf()
		var/list/valid_turfs = list()
		for (var/turf/T in range(spawn_range, src))
			if (is_valid_spawn_turf(T))
				valid_turfs += T
		if (valid_turfs.len == 0)
			return null
		return pick(valid_turfs)

	proc/is_valid_spawn_turf(turf/T)
		if (!(istype(T, accepted_turf)))
			return FALSE
		if (istype(T, /turf/closed))
			return FALSE
		if (!is_in_valid_area(T))
			return FALSE
		for (var/L in adventurer_landmarks)
			if (get_dist(T, L) < 10)
				return FALSE
		if (players_nearby(T, player_range))
			return FALSE
		return TRUE

	proc/is_in_valid_area(atom/A)
		var/area/area_check = get_area(A)
		return istype(area_check, valid_area)

	proc/get_all_adventurer_landmarks()
		var/list/landmarks = list()
		for (var/obj/effect/landmark/start/adventurer/L in world)
			landmarks += L
		for (var/obj/effect/landmark/start/adventurerlate/L in world)
			landmarks += L
		return landmarks

	proc/on_mob_destroy(mob/M)
		UnregisterSignal(M, COMSIG_PARENT_QDELETING)
		current_spawned_mobs = max(0, current_spawned_mobs - 1)
		total_spawned_mobs = max(0, total_spawned_mobs - 1)

	proc/players_nearby(turf/T, distance)
		for (var/mob/living/carbon/human/H in range(distance, T))
			if (H.client)
				return TRUE
		return FALSE
