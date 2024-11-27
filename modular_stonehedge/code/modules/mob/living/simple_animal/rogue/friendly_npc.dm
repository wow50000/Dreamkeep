//By Vide Noir https://github.com/EaglePhntm.
//templated on hearthstone sea raiders.

/mob/living/carbon/human/species/human/friendlynpc
	aggressive=1
	race = /datum/species/elf/wood
	mode = AI_IDLE
	faction = list("Station")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()
	erpable = TRUE
	wander = TRUE
	show_genitals = TRUE
	var/list/friendlyfactions = list("Station", "neutral", "rogueanimal", "saiga", "chickens", "goats", "cows", "turtles", "rats", "crabs", "horse")
	var/list/friendlyjobs
	//quotes from skyrim cause we love skyrim.
	var/list/calmmessages = list()
	var/list/aggromessages = list()
	var/mob/living/lasthitter = null

//would be great if we could make them follow stone roads while idle.
/mob/living/carbon/human/species/human/friendlynpc/should_target(mob/living/L)
	if(L == src)
		return FALSE
	if(L.stat != CONSCIOUS)
		return FALSE
	if(L.lying && !L.get_active_held_item())
		if(ishuman(L))
			var/mob/living/carbon/human/badboi = L
			if(badboi == lasthitter && Adjacent(badboi) && !badboi.handcuffed)
				//untested but yeah.
				say("I got you now, criminal scum.")
				scom_announce("I caught the criminal scum [badboi.real_name] at [get_area(src)].")
				var/obj/item/rope/ropey = new /obj/item/rope
				ropey.apply_cuffs(badboi, src)
				start_pulling(badboi)
		return FALSE
	if(L == lasthitter && L.alpha > 100)
		return TRUE
	if(ishuman(L))
		var/mob/living/carbon/human/madafaka = L
		if(madafaka.Adjacent(src) && mode != AI_HUNT && madafaka.mind && madafaka.alpha > 100)
			if(prob(10))
				face_atom(madafaka)
				emote(pick("turns to [madafaka].", "faces [madafaka]."))
				say(pick(calmmessages))
		if(friendlyfactions)
			if(madafaka.faction |= friendlyfactions && target != lasthitter)
				return FALSE
		if(friendlyjobs)
			if(madafaka.job |= friendlyjobs && target != lasthitter)
				return FALSE
	. = ..()

/mob/living/carbon/human/species/human/friendlynpc/MobBump(mob/M)
	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(lasthitter == L)
			say("Wait, I know you..!")
			if(L.alpha <= 100)
				L.apply_status_effect(/datum/status_effect/debuff/stealthcd)
			retaliate(L)
		else
			face_atom(L)
			emote(pick("turns to [L].", "faces [L]."))
			if(prob(10))
				say(pick(calmmessages))
	. = ..()

/mob/living/carbon/human/species/human/friendlynpc/townguard
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

//this does not work for some reason unfortunately
/*
/mob/living/carbon/human/species/human/friendlynpc/townguard/npc_idle()
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

/mob/living/carbon/human/species/human/friendlynpc/townguard/brute

/mob/living/carbon/human/species/human/friendlynpc/townguard/brute/after_creation()
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/friendlynpc/townguard/brute)


/mob/living/carbon/human/species/human/friendlynpc/townguard/retaliate(mob/living/L)
	var/newtarg = target
	lasthitter = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(target == newtarg)
			say(pick(aggromessages))
			linepoint(target)

/mob/living/carbon/human/species/human/friendlynpc/townguard/Initialize()
	gender = pick(MALE,FEMALE)
	. = ..()
	spawn(10)
		after_creation()
	//addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)

/mob/living/carbon/human/species/human/friendlynpc/townguard/after_creation()
	..()
	job = "Town Guardsman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BOG_TREKKING, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/friendlynpc/townguard)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes/night_vision/full_darksight) //elf eyes
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()

/mob/living/carbon/human/species/human/friendlynpc/townguard/handle_combat()
	if(mode == AI_HUNT)
		if(prob(10))
			emote("rage")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/friendlynpc/townguard/pre_equip(mob/living/carbon/human/H)
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
	H.STACON = 4
	H.STAEND = 15
	H.STAINT = 5
	H.STASTR = rand(11,16)
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

/datum/outfit/job/roguetown/human/species/human/friendlynpc/townguard/brute/pre_equip(mob/living/carbon/human/H)
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
	H.STACON = 8
	H.STAEND = 15
	H.STAINT = 5
	H.STASTR = rand(15,18)
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

/mob/living/carbon/human/species/human/friendlynpc/townguard/sentry
	patrol = FALSE
	wander = FALSE

/mob/living/carbon/human/species/human/friendlynpc/townguard/sentry/after_creation()
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/friendlynpc/townguard/sentry)

/datum/outfit/job/roguetown/human/species/human/friendlynpc/townguard/sentry/pre_equip(mob/living/carbon/human/H)
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
	H.STACON = 8
	H.STAEND = 15
	H.STAINT = 5
	H.STASTR = rand(15,18)
	r_hand = /obj/item/rogueweapon/halberd
	shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(H.gender == MALE)
		H.name = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
		H.real_name = H.name
	else
		H.name = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
		H.real_name = H.name
