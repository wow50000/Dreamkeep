/datum/job/roguetown/veteran
	title = "Guildmaster"
	flag = VETERAN
	department_flag = MERCENARIES
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE) //same as town guard
	allowed_races = RACES_ALL_KINDSPLUS // same as town guard
	tutorial = "You've known combat your entire life. There isn't a way to kill a man or beast you havent practiced in the tapestries of adventuring itself. You would call yourself a hero, given how you made much of this legacy through those you didn't leave behind. those belong to the men left rotting in the fields of where you practiced your ancient trade. You've slept better at night ever since you found purpose here..."
	display_order = JDO_VET
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/veteran
	give_bank_account = 1500
	min_pq = 10
	max_pq = null

	cmode_music = 'sound/music/combat_guard.ogg'

/datum/job/roguetown/veteran/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/half/vet))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "Guildmaster cloak ([index])"


/datum/outfit/job/roguetown/veteran/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/half/vet
	H.verbs |= /mob/proc/haltyell
	H.adjust_blindness(-3)
	var/classes = list(
	"Warrior",
	"Rogue",
	"Cleric",
	)
	var/classchoice = input("Choose your past", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Warrior")
			H.set_blindness(0)
			warriorarch(H)
		if("Rogue")
			H.set_blindness(0)
			roguearch(H)
		if("Cleric")
			H.set_blindness(0)
			clericarch(H)

/datum/outfit/job/roguetown/veteran/proc/warriorarch(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/roguetown/bervor
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/sword/sabre
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/storage/keyring/veteran = 1)
	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 5, TRUE)		//Actual cancer but he fucks. Hard.
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/medicine, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

//Rogue
/datum/outfit/job/roguetown/veteran/proc/roguearch(mob/living/carbon/human/H)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/rogue_vanish)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/hiddenblade
	if(H.gender == FEMALE) //funny
		armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/bikini
		pants = /obj/item/clothing/under/roguetown/chainlegs/fishnet
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
		pants = /obj/item/clothing/under/roguetown/chainlegs
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltr = /obj/item/quiver/Pbolts
	beltl = /obj/item/rogueweapon/sword/estoc
	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 5, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 5, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/stealing, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3 , TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/labor/butchering, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/traps, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/engineering, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/labor/butchering, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/lockpicking, 4, TRUE)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	backpack_contents = list(/obj/item/lockpickring/mundane, /obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 1, /obj/item/storage/keyring/veteran = 1)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	H.change_stat("perception", 1)
	H.change_stat("speed", 4)
	H.change_stat("intelligence", 2)

/datum/outfit/job/roguetown/veteran/proc/clericarch(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/roguetown/bervor
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/mace/steel
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/wood
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 1, /obj/item/storage/keyring/veteran = 1)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if(/datum/patron/inhumen/zizo)
			neck = /obj/item/clothing/neck/roguetown/psicross/skull
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
			H.mind.adjust_skillrank_up_to(/datum/skill/magic/druidic, 2, TRUE) // enough to craft druid mask, at least
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if(/datum/patron/divine/eora) //Eora content from Stonekeep
			neck = /obj/item/clothing/neck/roguetown/psicross/eora
	if(H.patron?.type == /datum/patron/divine/noc)
		C.grant_spells_devout_noc(H)
	else
		C.grant_spells_devout(H)
	H.set_blindness(0)
	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/magic/holy, 6, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 3, TRUE)
	H.change_stat("intelligence", 1)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2) // Stronger but less intelligent/quick compared to life clerics.
	H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.mind.AddSpell(new	/obj/effect/proc_holder/spell/targeted/churn)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/bladeward5e)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
