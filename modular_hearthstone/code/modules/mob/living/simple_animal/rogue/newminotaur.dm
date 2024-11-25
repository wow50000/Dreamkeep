/mob/living/simple_animal/hostile/retaliate/rogue/minotaur
	icon = 'modular_hearthstone/icons/mob/newminotaur.dmi'
	name = "Minotaur"
	icon_state = "MinotaurMale"
	icon_living = "MinotaurMale"
	icon_dead = "MinotaurMale_dead"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 2
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/minotaur_unarmed)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 10,
						/obj/item/natural/hide = 10, /obj/item/natural/bundle/bone/full = 2, /obj/item/natural/mino_head = 1)
	faction = list("caves")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 500
	maxHealth = 600
	melee_damage_lower = 55
	melee_damage_upper = 80
	vision_range = 3
	aggro_vision_range = 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 1
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 19
	STASTR = 16
	STASPD = 5
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 0
	food = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	dodgetime = 0
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	remains_type = /obj/item/rogueweapon/stoneaxe/battle
	erpable = TRUE
	hornychance = 50

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/Initialize()
	. = ..()
	pixel_x = -18
	give_genitals()

/obj/item/natural/mino_head
	name = "minotaur's head"
	icon = 'modular_hearthstone/icons/obj/items/mino_head.dmi'
	icon_state = "mino_head"
	desc = "Dismembered head of a mighty minotaur."
	dropshrink = null
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	sellprice = 80


/obj/item/natural/mino_head/female
	icon_state = "fmino_head"
	desc = "Dismembered head of a mighty female minotaur."


/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/female
	icon_state = "MinotaurFem"
	icon_living = "MinotaurFem"
	icon_dead = "MinotaurFem_dead"
	gender = FEMALE
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 10,
						/obj/item/natural/hide = 10, /obj/item/natural/bundle/bone/full = 2, /obj/item/natural/mino_head/female	 = 1)

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/axe
	icon_state = "MinotaurMale_Axe"
	icon_living = "MinotaurMale_Axe"
	icon_dead = "MinotaurMale_dead"
	base_intents = list(/datum/intent/simple/minotaur_axe)
	melee_damage_lower = 65
	melee_damage_upper = 85
	loot = list(/obj/item/rogueweapon/greataxe)

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/axe/female
	icon_state = "MinotaurFem_Axe"
	icon_living = "MinotaurFem_Axe"
	icon_dead = "MinotaurFem_dead"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 10,
						/obj/item/natural/hide = 10, /obj/item/natural/bundle/bone/full = 2, /obj/item/natural/mino_head/female	 = 1)

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/death(gibbed)
	..()
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/minotaur/minoroar.ogg','sound/vo/mobs/minotaur/minoroar2.ogg','sound/vo/mobs/minotaur/minoroar3.ogg','sound/vo/mobs/minotaur/minoroar4.ogg')
		if("pain")
			return pick('sound/vo/mobs/minotaur/minopain.ogg', 'sound/vo/mobs/minotaur/minopain2.ogg')
		if("death")
			return pick('sound/vo/mobs/minotaur/minodie.ogg', 'sound/vo/mobs/minotaur/minodie2.ogg')
		if("idle")
			return pick('sound/vo/mobs/minotaur/minoidle.ogg', 'sound/vo/mobs/minotaur/minoidle2.ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/datum/intent/simple/minotaur_unarmed
	name = "minotaur unarmed"
	icon_state = "instrike"
	attack_verb = list("punches", "strikes", "kicks", "steps on", "crushes", "bites")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"

/datum/intent/simple/minotaur_axe
	name = "minotaur axe"
	icon_state = "instrike"
	attack_verb = list("hacks at", "slashes", "chops", "steps on", "crushes", "bites")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "genchop"
	chargetime = 20
	penfactor = 10
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/horny
	seeksfuck = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/minotaur/female/horny
	seeksfuck = TRUE
	
