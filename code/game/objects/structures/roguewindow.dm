
/obj/structure/roguewindow
	name = "window"
	desc = "A glass window. Glass is very rare nowadays."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "window-solid"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	max_integrity = 100
	integrity_failure = 0.1
	var/base_state = "window-solid"
	var/lockdir = 0
	var/brokenstate = 0
	var/wallpress = TRUE
	blade_dulling = DULLING_BASHCHOP
	pass_flags = LETPASSTHROW
	climb_time = 20
	climb_offset = 10
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	break_sound = "glassbreak"
	destroy_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	var/curtains = FALSE
	var/currently_curtained = FALSE
	var/openable = FALSE
	var/currently_opened = FALSE
	var/stained = FALSE
	var/night_variants = FALSE
	leanable = TRUE

/obj/structure/roguewindow/Initialize()
	update_icon()
	..()

/obj/structure/roguewindow/update_icon()
	if(brokenstate)
		icon_state = "[base_state]br"
		return
	icon_state = "[base_state]"

/obj/structure/roguewindow/openclose/OnCrafted(dirin)
	dirin = turn(dirin, 180)
	lockdir = dirin
	. = ..(dirin)

/obj/structure/roguewindow/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if(!wallpress)
		return
	if(user == O && isliving(O))
		var/mob/living/L = O
		if(isanimal(L))
			var/mob/living/simple_animal/A = L
			if (!A.dextrous)
				return
		if(L.mobility_flags & MOBILITY_MOVE)
			wallpress(L)
			return

/obj/structure/roguewindow/proc/wallpress(mob/living/user)
	if(user.wallpressed) {
		// Release wallpressed state if already pressed
		release_wallpress(user)
		return
	}
	if(user.pixelshifted)
		return
	if(!(user.mobility_flags & MOBILITY_STAND))
		return
	var/dir2wall = get_dir(user, src)
	if(!(dir2wall in GLOB.cardinals))
		return
	user.wallpressed = dir2wall
	user.update_wallpress_slowdown()
	user.visible_message(span_info("[user] leans against [src]."))
	switch(dir2wall)
		if(NORTH)
			user.setDir(SOUTH)
			user.set_mob_offsets("wall_press", _x = 0, _y = 20)
		if(SOUTH)
			user.setDir(NORTH)
			user.set_mob_offsets("wall_press", _x = 0, _y = -10)
		if(EAST)
			user.setDir(WEST)
			user.set_mob_offsets("wall_press", _x = 12, _y = 0)
		if(WEST)
			user.setDir(EAST)
			user.set_mob_offsets("wall_press", _x = -12, _y = 0)

/obj/structure/roguewindow/proc/release_wallpress(mob/living/user)
	user.wallpressed = null
	user.update_wallpress_slowdown()
	user.set_mob_offsets("reset_wall_press", _x = 0, _y = 0)

/obj/structure/roguewindow/stained
	icon_state = null
	base_state = null
	opacity = TRUE
	max_integrity = 100
	integrity_failure = 0.5

/obj/structure/roguewindow/stained/silver
	icon_state = "stained-silver"
	base_state = "stained-silver"

/obj/structure/roguewindow/stained/yellow
	icon_state = "stained-yellow"
	base_state = "stained-yellow"

/obj/structure/roguewindow/stained/zizo
	icon_state = "stained-zizo"
	base_state = "stained-zizo"

/obj/structure/roguewindow/openclose
	icon_state = "woodwindowdir"
	base_state = "woodwindow"
	opacity = TRUE
	max_integrity = 100
	integrity_failure = 0.5

/obj/structure/roguewindow/openclose/reinforced
	desc = "A glass window. Glass is very rare nowadays. This one looks reinforced with a metal mesh."
	icon_state = "reinforcedwindowdir"
	base_state = "reinforcedwindow"
	max_integrity = 800
	integrity_failure = 0.1

/obj/structure/roguewindow/openclose/Initialize()
	lockdir = dir
	icon_state = base_state
	update_opacity()
	update_icon()
	if(night_variants)
		GLOB.TodUpdate += src
	return ..()

/obj/structure/roguewindow/Destroy()
	if(night_variants)
		GLOB.TodUpdate -= src
	return ..()

/obj/structure/roguewindow/update_tod(todd)
	update_icon()

/obj/structure/roguewindow/attack_hand(mob/user, params)
	. = ..()
	if(.)
		return
	if(brokenstate)
		return
	if(!user.cmode && curtains)
		if(try_toggle_curtains(user))
			return
	user.changeNext_move(CLICK_CD_MELEE)
	src.visible_message(span_info("[user] knocks on [src]."))
	add_fingerprint(user)
	playsound(src, 'sound/misc/glassknock.ogg', 100)

/obj/structure/roguewindow/attack_right(mob/user)
	if(user.cmode || !openable)
		return ..()
	try_toggle_opened(user)

/obj/structure/roguewindow/proc/try_toggle_opened(mob/user)
	if(!openable)
		return
	if(get_dir(src,user) != lockdir)
		to_chat(user, span_warning("The window doesn't close from this side."))
		return
	if(brokenstate)
		to_chat(user, span_warning("It's broken, that would be foolish."))
		return
	if(currently_opened)
		close_up(user)
	else
		open_up(user)
	update_opacity()
	update_icon()

/obj/structure/roguewindow/proc/try_toggle_curtains(mob/user)
	if(!openable)
		return FALSE
	if(get_dir(src,user) != lockdir)
		return FALSE
	if(brokenstate)
		return FALSE
	playsound(loc, 'sound/items/curtain.ogg', 50, TRUE)
	currently_curtained = !currently_curtained
	if(currently_curtained)
		to_chat(user, span_info("I close the curtains"))
	else
		to_chat(user, span_info("I open the curtains"))
	update_opacity()
	update_icon()
	return TRUE

/obj/structure/roguewindow/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE) && climbable)
		return 1
	if(isliving(mover))
		if(mover.throwing)
			if(!climbable)
				take_damage(10)
			if(brokenstate)
				return 1
	else if(isitem(mover))
		var/obj/item/I = mover
		if(I.throwforce >= 10)
			take_damage(10)
			if(brokenstate)
				return 1
		else
			return !density
	return ..()

/obj/structure/roguewindow/proc/force_open()
	playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
	climbable = TRUE
	opacity = FALSE
	update_icon()

/obj/structure/roguewindow/attackby(obj/item/W, mob/user, params)
	return ..()

/obj/structure/roguewindow/attack_paw(mob/living/user)
	attack_hand(user)

/obj/structure/roguewindow/obj_break(damage_flag)
	if(!brokenstate)
		attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
		new /obj/item/shard (get_turf(src))
		climbable = TRUE
		brokenstate = TRUE
		update_opacity()
	update_icon()
	..()

/obj/structure/roguewindow/proc/update_opacity()
	if(brokenstate)
		opacity = FALSE
		return
	if(openable && currently_opened)
		opacity = FALSE
		return
	if(stained)
		opacity = TRUE
		return
	if(curtains && currently_curtained)
		opacity = TRUE
		return
	opacity = FALSE

/obj/structure/roguewindow/proc/open_up(mob/user)
	visible_message(span_info("[user] opens [src]."))
	playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
	climbable = TRUE
	currently_opened = TRUE
	update_opacity()
	update_icon()

/obj/structure/roguewindow/proc/close_up(mob/user)
	visible_message(span_info("[user] closes [src]."))
	playsound(src, 'sound/foley/doors/windowdown.ogg', 100, FALSE)
	climbable = FALSE
	currently_opened = FALSE
	update_opacity()
	update_icon()

/obj/structure/roguewindow/update_icon()
	var/use_night_variant = FALSE
	if(night_variants)
		if(GLOB.tod == "night")
			use_night_variant = TRUE
	if(brokenstate)
		icon_state = "[base_state]-br"
	else if(openable && currently_opened)
		icon_state = "[base_state]-op"
	else if(curtains && currently_curtained)
		icon_state = "[base_state]-cur"
	else
		icon_state = "[base_state]"
	if(use_night_variant)
		icon_state = "[icon_state]-n"

/obj/structure/roguewindow/stained
	icon_state = null
	base_state = null
	stained = TRUE
	max_integrity = 100
	integrity_failure = 0.75

/obj/structure/roguewindow/stained/silver
	icon_state = "stained-silver"
	base_state = "stained-silver"

/obj/structure/roguewindow/stained/yellow
	icon_state = "stained-yellow"
	base_state = "stained-yellow"

/obj/structure/roguewindow/stained/zizo
	icon_state = "stained-zizo"
	base_state = "stained-zizo"

/obj/structure/roguewindow/openclose
	icon_state = "woodwindowdir"
	base_state = "woodwindow"
	opacity = TRUE
	stained = TRUE
	openable = TRUE
	night_variants = TRUE
	max_integrity = 100
	integrity_failure = 0.9

/obj/structure/roguewindow/openclose/reinforced
	desc = "A glass window. Glass is very rare nowadays. This one looks reinforced with a metal mesh."
	icon_state = "reinforcedwindowdir"
	base_state = "reinforcedwindow"
	max_integrity = 800
	integrity_failure = 0.1
	night_variants = FALSE

/obj/structure/roguewindow/curtain
	icon_state = "window-solid-dir"
	curtains = TRUE
	openable = TRUE
