/datum/job/roguetown/undertaker
	title = "Gravesinger"
	flag = GRAVEDIGGER
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	allowed_patrons = ALL_DIVINE_PATRONS //gets set to necra on the outfit anyways lol
	tutorial = "As an acolyte of a death god, you have been given the honor and rites  of putting the dead to rest instead of healing the living. Yamais bestows much wisdom in her reminders of our balance in life. Will you toil for her?"

	outfit = /datum/outfit/job/roguetown/undertaker
	display_order = JDO_GRAVEMAN
	give_bank_account = TRUE
	min_pq = 15
	max_pq = null

/datum/outfit/job/roguetown/undertaker
	allowed_patrons = list(/datum/patron/divine/necra,/datum/patron/divine/pestra)

/datum/outfit/job/roguetown/undertaker/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/necrahood
	neck = /obj/item/clothing/neck/roguetown/psicross/necra
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/necra
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/rope
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/silver =1, /obj/item/toy/cards/deck/tarot =1, /obj/item/scrying =1,)
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/rogueweapon/shovel
	backl = /obj/item/rogueweapon/sickle/scythe
	backl = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/magic/holy, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank_up_to(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("constitution", 2)
		H.change_stat("intelligence", -2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/combat_clergy.ogg'
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
