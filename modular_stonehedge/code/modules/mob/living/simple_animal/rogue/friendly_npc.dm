//By Vide Noir https://github.com/EaglePhntm.
//templated on hearthstone sea raiders.

/mob/living/carbon/human/species/human/smartnpc
	race = /datum/species/elf/wood
	mode = AI_IDLE
	faction = list("Station")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()
	erpable = TRUE
	wander = TRUE
	d_intent = INTENT_DODGE
	show_genitals = TRUE
	var/list/friendlyfactions = list("Station", "neutral", "rogueanimal", "saiga", "chickens", "goats", "cows", "turtles", "rats", "crabs", "horse")
	//using friendlyjobs will make this mob hostile to everyone not of those jobs, unless they are in friendlyfactions.
	var/list/friendlyjobs
	//quotes from skyrim cause we love skyrim.
	var/list/calmmessages = list()
	var/list/aggromessages = list()
	var/mob/living/lasthitter = null
	var/punish_attacking = FALSE

//would be great if we could make them follow stone roads while idle.
/mob/living/carbon/human/species/human/smartnpc/should_target(mob/living/L)
	if(!L)
		return FALSE

	if(L == src)
		return FALSE

	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		return FALSE

	if(!is_in_zweb(src.z,L.z))
		return FALSE

	if(L.alpha <= 100) //if mostly invisible dont see it, surely this wont go wrong.
		return FALSE

	if(L.InFullCritical())
		return FALSE

	if(L.name in friends)
		return FALSE

	if(L.stat != CONSCIOUS)
		return FALSE

	if(L.lying && !L.get_active_held_item())
		if(ishuman(L))
			var/mob/living/carbon/human/badboi = L
			if(badboi == lasthitter && Adjacent(badboi) && !badboi.handcuffed)
				//untested but yeah.
				say("I got you now, criminal scum.")
				scom_announce("I caught the criminal scum [badboi.real_name] at [get_area_name(get_area(src))].")
				var/obj/item/rope/ropey = new /obj/item/rope
				ropey.apply_cuffs(badboi, src)
				start_pulling(badboi, GRAB_AGGRESSIVE)
		return FALSE
	if(L == lasthitter && L.alpha > 100)
		return TRUE
	if(ishuman(L))
		var/mob/living/carbon/human/madafaka = L
		if(madafaka.Adjacent(src) && mode != AI_HUNT && madafaka.mind && madafaka.alpha > 100)
			if(prob(10))
				face_atom(madafaka)
				visible_message(span_emote(pick("[src] turns to [madafaka].", "[src] faces [madafaka].")))
				say(pick(calmmessages))
		if(friendlyfactions)
			var/list/madafaction = madafaka.faction
			if(find_match_in_list(madafaction, friendlyfactions) && lasthitter != target)
				return FALSE
			else
				return TRUE
		if(friendlyjobs)
			var/list/madajob = madafaka.job
			if((madajob in friendlyjobs) && lasthitter != target)
				return FALSE
			else
				return TRUE

	if(enemies[L])
		return TRUE

	return FALSE

/mob/living/carbon/human/species/human/smartnpc/MobBump(mob/M)
	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(lasthitter == L)
			say("Wait, I know you..!")
			if(L.alpha <= 100)
				L.apply_status_effect(/datum/status_effect/debuff/stealthcd)
			retaliate(L)
		else
			face_atom(L)
			visible_message(span_emote(pick("[src] turns to [L].", "[src] faces [L].")))
			if(prob(10))
				say(pick(calmmessages))
	. = ..()

/mob/living/carbon/human/species/human/smartnpc/townguard
	friendlyfactions = list("Station", "neutral")
	calmmessages = list(
		"Let me guess... someone stole your sweetroll.", 
		"I used to be an adventurer like you. Then I took an arrow in the knee...", 
		"Disrespect the law, and you disrespect me.", 
		"What do you need?", 
		"Trouble?",
		"What is it?",
		"No lollygaggin'.",
		"My cousin's out fighting dragons, and what do I get? Guard duty.",
		"Gotta keep my eyes open. Damn dragons could swoop down at any time.",
		"Fear not. Come dragon or giant, we'll be ready.",
		"Brigands I can handle, but this talk of dragons? World's gone mad, I say.",
		"Everything's in order.",
		"Staying safe I hope.",
		"Everything all right?",
		"Could sure use a warm bed right about now...",
		"I'd be a lot warmer and a lot happier with a bellyful of mead...",
		"I mostly deal with petty thievery and drunken brawls. Been too long since we've had a good bandit raid.",
		"What is it? Dragons?",
		"Watch the skies, traveler.",
		"I fear the night. Because the werewolves and vampires don't.",
		"Just a few more hours and I can crawl under some furs...",
		)
	aggromessages = list(
		"Never should have come here!",
		"Then let me speed your passage to Yamais' hands!",
		"Then pay with your blood!",
		"That can be arranged!",
		"So be it!",
		"You have sealed your fate!",
		"You cannot escape the righteous!",
		"Fool!",
		"You will pay, with your blood!",
		)
	var/patrol = TRUE
	var/lastpatroltime


// Custom idle behavior
/mob/living/carbon/human/species/human/smartnpc/townguard/npc_idle()
	if(patrol)
		if(world.time < next_idle + rand(30,50))
			return
		next_idle = world.time + rand(30,50)
		if(mode != AI_OFF)
			if(prob(50))
				var/turf/target_loc = find_suitable_location()
				if(target_loc)
					walk2derpless(target_loc)
	else
		. = ..()


// Find a suitable location to move to
/mob/living/carbon/human/species/human/smartnpc/townguard/proc/find_suitable_location()
	var/list/suitable_locations = list()

	// Collect all nearby stone road tiles
	for(var/turf/T in world)
		if((!istype(T, /turf/open/transparent/openspace) && !istype(T, /turf/open/floor/rogue/dirt) && !istype(T, /turf/open/floor/rogue/grass) && !istype(T, /turf/open/transparent/openspace) && !istype(T, /turf/open/lava) && !istype(T, /turf/open/lava/acid)) && get_dist(src, T) < 12) // Adjust distance as needed
			suitable_locations += T

	// Randomly select one of the suitable locations
	if(suitable_locations.len)
		return pick(suitable_locations)

	return null

//this does not work for some reason unfortunately
/*
/mob/living/carbon/human/species/human/smartnpc/townguard/npc_idle()
	. = ..()
	//im not smart enough to make a good patrol system but here.
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && patrol)
		if(prob(20))
			if(world.time > lastpatroltime + 10 SECONDS) //give em some time to reach and whatever
			var/foundpatrolpoints
			for(var/obj/effect/landmark/townpatrol/patrolpoint in orange(30,src))
				foundpatrolpoints += patrolpoint
			if(foundpatrolpoints)
				var/pickedpoint = get_closest_atom(/obj/effect/landmark/townpatrol, foundpatrolpoints, src)
				if(pickedpoint)
					walk2derpless(pickedpoint)
					lastpatroltime = world.time
			else
				//make them randomly go to a distant tile thats not foilage, if there is no patrol landmark around
				var/turf/open/T = oview(pick(13,24),src)
				if(!istype(T, /turf/open/transparent/openspace) && !istype(T, /turf/open/floor/rogue/dirt) && !istype(T, /turf/open/floor/rogue/grass))
					walk2derpless(T)

/obj/effect/landmark/townpatrol
	name = "patrol-point"
*/

/mob/living/carbon/human/species/human/smartnpc/townguard/brute

/mob/living/carbon/human/species/human/smartnpc/townguard/brute/after_creation()
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/smartnpc/townguard/brute)


/mob/living/carbon/human/species/human/smartnpc/townguard/retaliate(mob/living/L)
	var/newtarg = target
	if(L.job in list("Hedgeknight", "Hedgemaster"))
		return
	if(lasthitter != target)
		say(pick(aggromessages))
	lasthitter = target
	.=..()
	if(target)
		if(target == newtarg)
			linepoint(target)
			if(ishuman(target) && Adjacent(target))
				//i really REALLY want to punish players who try to strip those guys for loot, also they can do those badass moves on goblins too ig.
				if(prob(20) && !target.IsOffBalanced())
					say(pick("Aha!", "Parry this!", "Ha-haa!"))
					visible_message(span_emote("[src] feints an attack at [target]!"))
					target.OffBalance(50) //since they cant defeat the parries might aswell give them a fat feint.
				else if(prob(10))
					say(pick("Sit the fuck down.", "Fuck away from me.", "Stay down."))
					visible_message(span_emote("[src] bashes [target] away!"))
					playsound(src,"punch_hard",100,TRUE)
					target.Knockdown(25) //may end up getting you tied real fast.
					target.throw_at(target, pick(2,3), 1, src, FALSE, TRUE)
				else if(prob(5) && target.get_active_held_item())
					var/obj/item/activeitem = target.get_active_held_item()
					if(!HAS_TRAIT(activeitem, TRAIT_NODROP))
						say(pick("You are done.", "Ha! There goes your [activeitem.name]!", "You fucked up now!"))
						visible_message(span_emote("[src] disarms [target]!"))
						playsound(src,"bladedmedium",100,TRUE)
						target.OffBalance(15)
						target.throw_at(activeitem, get_step_away(activeitem, target, 3), 1, target, TRUE, FALSE)
				if(punish_attacking)
					var/bounty_exists = FALSE
					for(var/datum/bounty/b in GLOB.head_bounties)
						if(b.target == target.real_name)
							bounty_exists = TRUE
					if(!bounty_exists)
						add_bounty(L.real_name, 500, FALSE, "Attacking a town guardsman.", "Town of Stonehedge")
						var/bounty_announcement = "[target] is accused of attacking a town guardsman at [get_area_name(get_area(src))], wanted with a bounty of 500 mammons."
						say("Stop right there, criminal scum!")
						scom_announce(bounty_announcement)
						to_chat(L, span_notice("I got a bounty on my head now!"))
					else
						scom_announce("the criminal [target] is reported attacking a townsguard at [get_area_name(get_area(src))].")

/mob/living/carbon/human/species/human/smartnpc/townguard/Initialize()
	gender = pick(MALE,FEMALE)
	. = ..()
	spawn(10)
		after_creation()
	//addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)

/mob/living/carbon/human/species/human/smartnpc/townguard/after_creation()
	..()
	job = "Town Guardsman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BOG_TREKKING, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/smartnpc/townguard)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes/night_vision/full_darksight) //elf eyes
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()

/mob/living/carbon/human/species/human/smartnpc/townguard/handle_combat()
	if(mode == AI_HUNT)
		if(prob(10))
			emote("rage")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/smartnpc/townguard/pre_equip(mob/living/carbon/human/H)
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	cloak = /obj/item/clothing/cloak/templar/dendor
	gloves = /obj/item/clothing/gloves/roguetown/forestergauntlets
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/foresterarmor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/tights
	head = /obj/item/clothing/head/roguetown/helmet/foresterhelmet
	H.STASPD = 8
	H.STAPER = 10
	H.STACON = 14
	H.STAEND = 15
	H.STAINT = 12
	H.STASTR = rand(13,16)
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword
	else
		r_hand = /obj/item/rogueweapon/mace
	l_hand = /obj/item/rogueweapon/shield/tower
	shoes = /obj/item/clothing/shoes/roguetown/boots/forestershoes
	if(prob(30))
		neck = /obj/item/clothing/neck/roguetown/chaincoif
		H.eye_color = pick("27becc", "35cc27", "000000")
	H.hair_color = pick ("4f4f4f", "61310f", "faf6b9")
	H.facial_hair_color = H.hair_color
	if(H.gender == MALE)
		H.name = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
		H.real_name = H.name
	else
		H.name = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
		H.real_name = H.name

/datum/outfit/job/roguetown/human/species/human/smartnpc/townguard/brute/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	cloak = /obj/item/clothing/cloak/templar/dendor
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	head = /obj/item/clothing/head/roguetown/helmet/elfbarbutewings
	if(prob(60))
		mask = /obj/item/clothing/mask/rogue/facemask
	gloves = /obj/item/clothing/gloves/roguetown/chain
	H.STASPD = 9
	H.STAPER = 10
	H.STACON = 16
	H.STAEND = 16
	H.STAINT = 14
	H.STASTR = rand(14,16)
	if(prob(50))
		r_hand = /obj/item/rogueweapon/halberd/bardiche
	else
		r_hand = /obj/item/rogueweapon/greatsword
	shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(H.gender == MALE)
		H.name = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
		H.real_name = H.name
	else
		H.name = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
		H.real_name = H.name

/mob/living/carbon/human/species/human/smartnpc/townguard/sentry
	patrol = FALSE
	wander = FALSE
	var/turf/spawned_loc

/mob/living/carbon/human/species/human/smartnpc/townguard/sentry/Initialize()
	. = ..()
	spawned_loc = get_turf(src)
	addtimer(CALLBACK(src, PROC_REF(return_to_post)), 5 MINUTES, TIMER_STOPPABLE)

/mob/living/carbon/human/species/human/smartnpc/townguard/sentry/proc/return_to_post()
	if(src.loc != spawned_loc)
		walk2derpless(spawned_loc)
		wander = FALSE
	addtimer(CALLBACK(src, PROC_REF(return_to_post)), 5 MINUTES, TIMER_STOPPABLE)

/mob/living/carbon/human/species/human/smartnpc/townguard/sentry/after_creation()
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/smartnpc/townguard/sentry)

/datum/outfit/job/roguetown/human/species/human/smartnpc/townguard/sentry/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	cloak = /obj/item/clothing/cloak/templar/dendor
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	head = /obj/item/clothing/head/roguetown/helmet/elfbarbutewings
	if(prob(60))
		mask = /obj/item/clothing/mask/rogue/facemask
	gloves = /obj/item/clothing/gloves/roguetown/chain
	H.STASPD = 9
	H.STAPER = 10
	H.STACON = 16
	H.STAEND = 16
	H.STAINT = 14
	H.STASTR = rand(14,16)
	r_hand = /obj/item/rogueweapon/halberd
	shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(H.gender == MALE)
		H.name = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
		H.real_name = H.name
	else
		H.name = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
		H.real_name = H.name
