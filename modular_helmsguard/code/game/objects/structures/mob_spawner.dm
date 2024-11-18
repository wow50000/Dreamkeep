/// ONLY TEMPLATE ///
/*
	MADE BY STONEDELF A.K.A FERALAPE

THESE SPAWNERS SPAWN MOBS BY CHOOSING RANDOM TILES AROUND IT AND SCATTERING THE MOBS, WORKS SIMILARLY TO BOG AMBUSHES

*/


/// PHYSICAL DESTRUCTIBLE SPAWNER ///


/obj/structure/mobspawner
	name = "mob spawner"
	desc = ""
//	icon = 'icons/mob/animal.dmi'
//	icon_state = "hole"
	max_integrity = 500
	anchored = TRUE
	density = TRUE
	attacked_sound = 'sound/misc/woodhit.ogg'
	destroy_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	var/ready = FALSE
	var/last_activated
	var/detect_range = 6
	var/spawn_range = 3
	var/restart_time = 8 MINUTES
	var/min_mobs = 1
	var/max_mobs = 3
	var/mobs = 0
	var/mobs_to_spawn = 3
	var/mob_types = list(/mob/living/simple_animal/hostile/carp = 100)
	var/text_faction = "Space carps"	//for spawning string
	var/spawn_text = "emerges from"		//for spawning string
	var/list/spawn_sound = list('sound/misc/jumpscare (1).ogg', 'sound/misc/jumpscare (2).ogg', 'sound/misc/jumpscare (3).ogg', 'sound/misc/jumpscare (4).ogg')
	var/list/objfaction = list("test")
	var/list/mymobs = list()

/obj/structure/mobspawner/Initialize()
	. = ..()
	proximity_monitor = new(src, 6)
	ready = TRUE
	START_PROCESSING(SSobj, src)


/obj/structure/mobspawner/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/mobspawner/process()
	if(world.time > last_activated + restart_time)
		ready = TRUE
	if(ready)
		for(var/mob/living/M in view(detect_range, src))
			if((objfaction[1] in M.faction) || M.incapacitated() || M.restrained() || M.IsSleeping() || (M.stat == DEAD) || M.InFullCritical())
				return
			else
				playsound(src, pick(spawn_sound), 100)
				shake_camera(M, 3, 1)
				M.visible_message("<span class='danger'>[text_faction] [spawn_text] [src]</span>")
				activate()

/*/obj/structure/mobspawner/HasProximity(atom/movable/AM)
	if(ready)
		if(istype(AM, /mob/living))
			var/mob/living/L = AM
			if(objfaction[1] in L.faction)
				return
			else
				activate()*/

/obj/structure/mobspawner/proc/activate()
	last_activated = world.time
	mobs_to_spawn = rand(min_mobs, max_mobs)
	while(mobs < mobs_to_spawn)
		spawn_mob()
		if(mobs == mobs_to_spawn)
			ready = FALSE
			reset()
			break

/obj/structure/mobspawner/proc/spawn_mob()
	var/turf/open/floor/spawning_turf
	var/list/turf/open/floor/spawning_turfs = list()
	for(var/turf/open/floor/spot in view(spawn_range, src))
		spawning_turfs += spot
	if(length(spawning_turfs))
		spawning_turf = pick(spawning_turfs)
		var/spawnmob = pickweight(mob_types)
		mymobs += new spawnmob(spawning_turf)
		mobs ++
		for(var/mob/living/c in mymobs)
			c.del_on_deaggro = (restart_time - 1 MINUTES)
			c.faction = objfaction.Copy()
			if(QDELETED(c) || c.stat == DEAD)
				mymobs.Remove(c)
	if(!spawning_turf)
		return

/obj/structure/mobspawner/proc/reset()
	mobs_to_spawn = 3
	mobs = 0


/obj/structure/mobspawner/deconstruct(disassembled = TRUE)
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	if(islist(debris))
		for(var/I in debris)
			var/count = debris[I] + rand(-1,1)
			if(count > 0)
				for(var/i in 1 to count)
					new I (get_turf(src))
	if(islist(static_debris))
		for(var/I in static_debris)
			for(var/i in 1 to static_debris[I])
				new I (get_turf(src))
	qdel(src)

/obj/structure/mobspawner/obj_destruction(damage_flag)
	STOP_PROCESSING(SSobj, src)
	obj_destroyed = TRUE
	if(damage_flag == "acid")
		acid_melt()
	else if(damage_flag == "fire")
		burn()
	else
		if(destroy_sound)
			playsound(get_turf(src), destroy_sound, 100, TRUE)
		if(destroy_message)
			visible_message(destroy_message)
		deconstruct(FALSE)
	return TRUE




/// INVISIBLE INDESTRUCTIBLE SPAWNER ///

/obj/effect/mobspawner
	name = "mob spawner"
	desc = ""
	anchored = TRUE
	density = FALSE
	var/ready = FALSE
	var/last_activated
	var/mobs = 0
	var/detect_range = 6
	var/spawn_range = 3
	var/restart_time = 8 MINUTES
	var/min_mobs = 1
	var/max_mobs = 3
	var/mobs_to_spawn = 3
	var/mob_types = list(/mob/living/simple_animal/hostile/carp = 100)
	var/text_faction = "Space carps"	//for spawning string
	var/list/notification_strings = list("appeared from hiding!", "laid an ambush!", "emerges from the shadows!", "lunged from their hiding place!",
	"revealed themselves suddenly!")
	var/picked_string = null
	var/list/spawn_sound = list('sound/misc/jumpscare (1).ogg', 'sound/misc/jumpscare (2).ogg', 'sound/misc/jumpscare (3).ogg', 'sound/misc/jumpscare (4).ogg')
	var/list/objfaction = list("test")
	var/list/mymobs = list()

/obj/effect/mobspawner/Initialize()
	. = ..()
	proximity_monitor = new(src, 6)
	ready = TRUE
	picked_string = pick(notification_strings)
	START_PROCESSING(SSobj, src)

/obj/effect/mobspawner/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/mobspawner/process()
	if(world.time > last_activated + restart_time)
		ready = TRUE
		picked_string = pick(notification_strings)
	if(ready)
		for(var/mob/living/M in view(detect_range, src))
			if((objfaction[1] in M.faction) || M.incapacitated() || M.restrained() || M.IsSleeping() || (M.stat == DEAD) || M.InFullCritical())
				return
			else
				playsound(src, pick(spawn_sound), 100)
				shake_camera(M, 3, 1)
				M.visible_message("<span class='danger'>[text_faction] [picked_string]</span>")
				activate()

/obj/effect/mobspawner/proc/activate()
	last_activated = world.time
	mobs_to_spawn = rand(min_mobs, max_mobs)
	while(mobs < mobs_to_spawn)
		spawn_mob()
		if(mobs == mobs_to_spawn)
			ready = FALSE
			reset()
			break


/obj/effect/mobspawner/proc/spawn_mob()
	var/turf/open/floor/spawning_turf
	var/list/turf/open/floor/spawning_turfs = list()
	for(var/turf/open/floor/spot in view(spawn_range, src))
		spawning_turfs += spot
	if(length(spawning_turfs))
		spawning_turf = pick(spawning_turfs)
		var/spawnmob = pickweight(mob_types)
		mymobs += new spawnmob(spawning_turf)
		mobs ++
		for(var/mob/living/c in mymobs)
			c.del_on_deaggro = (restart_time - 1 MINUTES)
			c.faction = objfaction.Copy()
			if(QDELETED(c) || c.stat == DEAD)
				mymobs.Remove(c)
		mobs ++
	if(!spawning_turf)
		return

/obj/effect/mobspawner/proc/reset()
	mobs_to_spawn = 3
	mobs = 0




/// HOLE SPAWNER ///
/* THIS ONE DOESN'T SCATTER ITS MOBS BUT INSTEAD SPAWN ON ITS OWN TILE */


/obj/effect/mobspawner/hole
	name = "the hole"
	desc = ""
	icon = 'modular_helmsguard/icons/obj/structure/spawners.dmi'
	icon_state = "hole"
	anchored = TRUE
	density = FALSE
	ready = FALSE
	last_activated
	mobs = 0
	detect_range = 6
	spawn_range = null
	restart_time = 1 MINUTES
	min_mobs = 1
	max_mobs = 2
	mobs_to_spawn = 3
	mob_types = list(/mob/living/simple_animal/hostile/carp = 100)
	text_faction = null
	notification_strings = list("climbs out of")
	picked_string = null
	notification_strings = list("climbs out of", "emerges from", "crawls out of", "creeps out from")
	objfaction = list("test")
	mymobs = list()

/obj/effect/mobspawner/hole/Initialize()
	. = ..()
	proximity_monitor = new(src, 6)
	ready = TRUE
	picked_string = pick(notification_strings)
	START_PROCESSING(SSobj, src)

/obj/effect/mobspawner/hole/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/mobspawner/hole/process()
	if(world.time > last_activated + restart_time)
		ready = TRUE
		picked_string = pick(notification_strings)
	if(ready)
		for(var/mob/living/M in view(detect_range, src))
			if((objfaction[1] in M.faction) || M.incapacitated() || M.restrained() || M.IsSleeping() || (M.stat == DEAD) || M.InFullCritical())
				return
			else
				activate()

/obj/effect/mobspawner/hole/activate()
	last_activated = world.time
	mobs_to_spawn = rand(min_mobs, max_mobs)
	while(mobs < mobs_to_spawn)
		spawn_mob()
		if(mobs == mobs_to_spawn)
			ready = FALSE
			reset()
			break

/obj/effect/mobspawner/hole/spawn_mob()
	var/spawnmob = pickweight(mob_types)
	var/mob/living/damob = spawnmob
	src.visible_message("<span class='danger'>[damob.name] [picked_string] [src]!</span>")
	playsound(src, pick(spawn_sound), 100)
	mymobs += new spawnmob(get_turf(src))
	mobs ++
	for(var/mob/living/c in mymobs)
		c.del_on_deaggro = (restart_time - 1 MINUTES)
		c.faction = objfaction.Copy()
		if(QDELETED(c) || c.stat == DEAD)
			mymobs.Remove(c)

/obj/effect/mobspawner/hole/reset()
	mobs_to_spawn = 3
	mobs = 0