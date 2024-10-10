

//these mobs run away when attacked
/mob/living/simple_animal/hostile/retaliate/rogue
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	faction = list("rogueanimal")
	robust_searching = 1
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	attack_sound = PUNCHWOOSH
	health = 40
	maxHealth = 40
	move_to_delay = 5
	d_intent = INTENT_DODGE
	minbodytemp = 180
	lose_patience_timeout = 150
	vision_range = 5
	aggro_vision_range = 18
	harm_intent_damage = 5
	attack_same = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	blood_volume = BLOOD_VOLUME_NORMAL
	food_type = list(/obj/item/reagent_containers/food/snacks/grown)
	var/obj/item/udder/udder = null
	footstep_type = FOOTSTEP_MOB_SHOE
	var/milkies = FALSE
	stop_automated_movement_when_pulled = 0
	tame_chance = 0
	retreat_distance = 10
	minimum_distance = 10
	dodge_sound = 'sound/combat/dodge.ogg'
	dodge_prob = 0
	var/deaggroprob = 10
	var/eat_forever
	candodge = TRUE


/mob/living/simple_animal/hostile/retaliate/rogue/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE)
	..()
	if(damagetype == BRUTE)
		if(damage > 5 && prob(damage * 3))
			emote("pain")
		if(damage > 10)
			Immobilize(clamp(damage/2, 1, 30))
			shake_camera(src, 1, 1)
		if(damage < 10)
			flash_fullscreen("redflash1")
		else if(damage < 20)
			flash_fullscreen("redflash2")
		else if(damage >= 20)
			flash_fullscreen("redflash3")
	if(damagetype == BURN)
		if(damage > 10 && prob(damage))
			emote("pain")
			shake_camera(src, 1, 1)
		if(damage < 10)
			flash_fullscreen("redflash1")
		else if(damage < 20)
			flash_fullscreen("redflash2")
		else if(damage >= 20)
			flash_fullscreen("redflash3")

/mob/living/simple_animal/hostile/retaliate/rogue/death(gibbed)
	emote("death")
	..(gibbed)

/mob/living/simple_animal/hostile/retaliate/rogue/handle_automated_movement()
	set waitfor = FALSE
	if(!stop_automated_movement && wander && !doing)
		if(ssaddle && has_buckled_mobs())
			return 0
		if(find_food())
			return
		else
			..()

/mob/living/simple_animal/hostile/retaliate/rogue/proc/find_food()
	if(food > 50 && !eat_forever)
		return
	var/list/around = view(1, src)
	var/list/foundfood = list()
	if(stat)
		return
	for(var/obj/item/F in around)
		if(is_type_in_list(F, food_type))
			foundfood += F
			if(src.Adjacent(F))
				face_atom(F)
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				qdel(F)
				food = max(food + 30, 100)
				return TRUE
	for(var/obj/item/F in foundfood)
		if(is_type_in_list(F, food_type))
			var/turf/T = get_turf(F)
			Goto(T,move_to_delay,0)
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/proc/eat_bodies()
	var/mob/living/L
//	var/list/around = view(aggro_vision_range, src)
	var/list/around = hearers(1, src)
	var/list/foundfood = list()
	if(stat)
		return
	for(var/mob/living/eattarg in around)
		if(!(eattarg in enemies)) //Makes a tamed rous not eat people on the floor unless instigated.
			return
		if(eattarg.stat != CONSCIOUS)
			foundfood += eattarg
			L = eattarg
			if(src.Adjacent(L))
				if(iscarbon(L))
					var/mob/living/carbon/C = L
					if(attack_sound)
						playsound(src, pick(attack_sound), 100, TRUE, -1)
					face_atom(C)
					src.visible_message(span_danger("[src] starts to rip apart [C]!"))
					if(do_after(src,100, target = L))
						var/obj/item/bodypart/limb
						var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
						for(var/zone in limb_list)
							limb = C.get_bodypart(zone)
							if(limb)
								limb.dismember()
								return TRUE
						limb = C.get_bodypart(BODY_ZONE_HEAD)
						if(limb)
							limb.dismember()
							return TRUE
						limb = C.get_bodypart(BODY_ZONE_CHEST)
						if(limb)
							if(!limb.dismember())
								C.gib()
							return TRUE
				else
					if(attack_sound)
						playsound(src, pick(attack_sound), 100, TRUE, -1)
					src.visible_message(span_danger("[src] starts to rip apart [L]!"))
					if(do_after(src,100, target = L))
						L.gib()
						return TRUE
	for(var/mob/living/eattarg in foundfood)
		var/turf/T = get_turf(eattarg)
		Goto(T,move_to_delay,0)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/Initialize()
	..()
	if(milkies)
		udder = new()
	if(tame)
		tamed()
	ADD_TRAIT(src, TRAIT_SIMPLE_WOUNDS, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/LoseTarget()
	..()
	retreat_distance = initial(retreat_distance)
	minimum_distance = initial(minimum_distance)

/mob/living/simple_animal/hostile/retaliate/rogue/tamed()
	del_on_deaggro = 0
	aggressive = 0
	if(enemies.len)
		if(prob(23))
			enemies = list()
			src.visible_message(span_notice("[src] calms down."))
			
		else
			return
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/Destroy()
	qdel(udder)
	udder = null
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/Life()
	. = ..()
	if(.)
		if(enemies.len)
			if(prob(5))
				emote("cidle")
			if(prob(deaggroprob))
				if(mob_timers["aggro_time"])
					if(world.time > mob_timers["aggro_time"] + 30 SECONDS)
						enemies = list()
						src.visible_message(span_info("[src] calms down."))
						LoseTarget()
				else
					mob_timers["aggro_time"] = world.time
		else
			if(prob(8))
				emote("idle")
//			for(var/direction in shuffle(list(1,2,4,8,5,6,9,10)))
//				var/step = get_step(src, direction)
//				if(step)
//					var/obj/item/reagent_containers/food/I = locate(/obj/item/reagent_containers/food) in step
//					if(is_type_in_list(I, food_type))
//						Move(step, get_dir(src, step))
			if(adult_growth)
				growth_prog += 0.5
				if(growth_prog >= 100)
					if(isturf(loc))
						var/mob/living/simple_animal/A = new adult_growth(loc)
						if(tame)
							A.tame = TRUE
						qdel(src)
						return
			else
				if(childtype)
					make_babies()
		if(udder)
			if(production > 0)
				production--
				udder.generateMilk()

//sex stuff brainrot --vide noir
		if(!isfucking && seeksfuck && fuckcd > 0)
			fuckcd -= 1
		if(sexcon && seeksfuck && !isfucking && !fuckcd && prob(100) && !chasesfuck && !src.retreating)
			var/list/around = view(aggro_vision_range, src)
			for(var/mob/living/carbon/human/fucktarg in around)
				var/datum/sex_controller/sc = fucktarg.sexcon
				if(!src.aggressive && fucktarg.cmode) //skip if the target has cmode on and the mob is not aggressive.
					continue
				if(fucktarg.has_quirk(/datum/quirk/monsterhunter) && !sc.beingfucked)
					chasesfuck = TRUE
					if(src.gender == MALE)
						src.visible_message(span_boldwarning("[src] has his eyes on [fucktarg], cock throbbing!"))
						src.say(pick("Come here, mate!", "I smell a mate..!", "I'm going to get in you!",  "You will breed with me!"), language = /datum/language/common)
					else
						src.visible_message(span_boldwarning("[src] has her eyes on [fucktarg], cunt dripping!"))
						src.say(pick("Come here, mate!", "I smell a mate..!", "I'm going to get you in me!", "You will breed with me!"), language = /datum/language/common)
					break
				else
					continue
		if(chasesfuck && !retreating) //until fuck is acquired, keep chasing.
			seekboredom += 1
			enemies = list()
			target = null
			approaching_target = FALSE
			in_melee = FALSE
			if(prob(10))
				if(src.gender == MALE)
					src.visible_message(span_warning("[src] seeks his mate, cock throbbing!"))
					src.say(pick("I'll catch you yet...", "I smell a mate...", "I'm going to get in you!",  "You will breed with me!"), language = /datum/language/common)
				else
					src.visible_message(span_warning("[src] seeks her mate, cunt dripping!"))
					src.say(pick("I'll catch you yet...", "I smell a mate...", "I'm going to get you in me!", "You will breed with me!"), language = /datum/language/common)
			seeklewd()
		if(seekboredom > 25) //give up after a while and go dormant again, this should also help them get unstuck.
			stoppedfucking(src, TRUE)
		if(retreating && chasesfuck) //we are outta here
			stoppedfucking(src, TRUE)


/mob/living/simple_animal/hostile/retaliate/rogue/Retaliate()
//	if(!enemies.len && message)
//		src.visible_message(span_warning("[src] panics!"))
//	if(flee)
//		retreat_distance = 10
//		minimum_distance = 10
	mob_timers["aggro_time"] = world.time
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/attackby(obj/item/O, mob/user, params)
	if(!stat && istype(O, /obj/item/reagent_containers/glass))
		if(udder && tame)
			udder.milkAnimal(O, user)
			return 1
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/proc/return_action()
	stop_automated_movement = FALSE
	walk(src,0)

/mob/living/simple_animal/hostile/retaliate/rogue/shood(mob/user)
	if(tame)
		Retaliate()

/mob/living/simple_animal/hostile/retaliate/rogue/onkick(mob/M)
	..()
	Retaliate()
	GiveTarget(M)

/mob/living/simple_animal/hostile/retaliate/rogue/beckoned(mob/user)
	if(tame && !stop_automated_movement)
		stop_automated_movement = TRUE
		Goto(user,move_to_delay)
		addtimer(CALLBACK(src, PROC_REF(return_action)), 3 SECONDS)

/mob/living/simple_animal/hostile/retaliate/rogue/food_tempted(obj/item/O, mob/user)
	testing("tempted")
	if(is_type_in_list(O, food_type) && !stop_automated_movement)
		testing("infoodtype")
		stop_automated_movement = TRUE
		Goto(user,move_to_delay)
		addtimer(CALLBACK(src, PROC_REF(return_action)), 3 SECONDS)

/mob/living/simple_animal/hostile/retaliate/rogue/proc/seeklewd()
	var/mob/living/carbon/human/L
	var/list/around = view(aggro_vision_range, src)
	var/list/foundfuckmeat = list()
	if(isfucking && fuckcd > 0)
		return
	for(var/mob/living/carbon/human/fucktarg in around)
		if(!src.retreating && fucktarg.has_quirk(/datum/quirk/monsterhunter))
			foundfuckmeat += fucktarg
			L = fucktarg
			if(src.Adjacent(L))
				if(iscarbon(L))
					isfucking = TRUE
					chasesfuck = FALSE
					if(attack_sound)
						playsound(src, pick(attack_sound), 100, TRUE, -1)
					stop_automated_movement = TRUE
					if(L.cmode)
						L.SetImmobilized(20)
						L.SetKnockdown(20)
					else
						L.SetImmobilized(50)
						L.SetKnockdown(50)
					if(!L.lying)
						L.emote("gasp")
					if(!L.cmode && L.wear_pants) //pants off if not in cmode
						L.dropItemToGround(L.wear_pants)
						L.wear_pants.throw_at(orange(2, get_turf(L)), 2, 1, src, TRUE)
					else if(L.cmode && L.wear_pants)
						src.visible_message(span_danger("[src] manages to tug [L]'s [L.wear_pants.name] out of the way!"))
					enemies = list()
					target = null
					approaching_target = FALSE
					in_melee = FALSE
					var/datum/sex_controller/sc = src.sexcon
					toggle_ai(AI_OFF)
					if(aggressive)
						sc.force = SEX_FORCE_MAX
					else
						sc.force = SEX_FORCE_MID
					src.throw_at(get_turf(L.loc), 3, 3, spin = FALSE)
					if(!get_turf(src) == get_turf(L)) //are we at the same tile?
						walk_to(src, get_turf(L.loc), 1, move_to_delay) //get on them.
					src.visible_message(span_danger("[src] starts to breed [L]!"))
					if(sc.force == SEX_FORCE_MAX)
						src.visible_message(span_danger("[src] pins [L] down for a savage fucking!"))
					else
						src.visible_message(span_info("[src] climbs on [L] to breed."))
					sc.speed = SEX_SPEED_MAX
					if(gender == MALE)
						sc.manual_arousal = SEX_MANUAL_AROUSAL_MAX
					log_admin("[src] is trying to init sex on [L]")
					var/current_action = /datum/sex_action/npc_rimming
					if(src.gender == FEMALE && L.gender == MALE)
						switch(rand(3))
							if(1) //oral
								current_action = /datum/sex_action/npc_facesitting
							if(2) //anal
								current_action = /datum/sex_action/npc_anal_ride_sex
							if(3) //vaginal
								current_action = /datum/sex_action/npc_vaginal_ride_sex
					if(src.gender == MALE && L.gender == MALE)
						switch(rand(3))
							if(1) //oral
								current_action = /datum/sex_action/npc_throat_sex
							if(2) //anal
								current_action = /datum/sex_action/npc_anal_sex
							if(3) //vaginal
								current_action = /datum/sex_action/npc_anal_sex
					if(src.gender == MALE && L.gender == FEMALE)
						switch(rand(3))
							if(1) //oral
								current_action = /datum/sex_action/npc_throat_sex
							if(2) //anal
								current_action = /datum/sex_action/npc_anal_sex
							if(3) //vaginal
								current_action = /datum/sex_action/npc_vaginal_sex
					if(src.gender == FEMALE && L.gender == FEMALE)
						switch(rand(3))
							if(1) //oral
								current_action = /datum/sex_action/npc_facesitting
							if(2) //anal
								current_action = /datum/sex_action/npc_rimming
							if(3) //vaginal
								current_action = /datum/sex_action/npc_cunnilingus
					sc.do_until_finished = TRUE
					sc.target = L
					sc.try_start_action(current_action)
					return
	for(var/mob/living/fucktarg in foundfuckmeat)
		var/turf/T = get_turf(fucktarg)
		Goto(T,move_to_delay,0)
		return
	return 

/mob/living/simple_animal/hostile/retaliate/rogue/proc/stoppedfucking(timedout = FALSE)
	walk_away(src, get_turf(src.loc), 4, move_to_delay)
	isfucking = FALSE
	chasesfuck = FALSE
	seekboredom = 0
	toggle_ai(AI_ON)
	var/datum/sex_controller/sc = src.sexcon
	if(sc.just_ejaculated() || timedout) //is it satisfied or given up
		fuckcd = rand(50,350)
	else
		fuckcd = rand(20,80)
		if(aggressive)
			//if its in combat and unsatisfied by prey slipping off, it will wanna try again. But with some delay so the person can actually get up
			// and if they are taking turns with multiple seeksfuck mobs around this may help a bit.
			fuckcd = rand(10,20)
	stop_automated_movement = 0

/mob/living/simple_animal/hostile/retaliate/rogue/Retaliate()
	. = ..()
	if(src.isfucking)
		src.stoppedfucking()
