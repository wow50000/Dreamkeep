/datum/reagent/medicine/minorhealthpot
	name = "Minor Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff9494"
	taste_description = "tangy sweetness"
	overdose_threshold = 0
	metabolization_rate = 1 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/minorhealthpot/on_mob_life(mob/living/carbon/M) // Heals half as much as health potion, but not wounds.
	M.adjustBruteLoss(-0.5*REM, 0) // 20u = 25 points of healing
	M.adjustFireLoss(-0.5*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff5151"
	taste_description = "warm oil and flesh"
	overdose_threshold = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		//some peeps dislike the church, this allows an alternative thats not a doctor or sleep.
		M.heal_wounds(1)
		M.update_damage_overlays()
		to_chat(M, span_nicegreen("I feel one of my wounds mend."))
	M.adjustBruteLoss(-0.5*REM, 0) // 20u = 50 points of healing
	M.adjustFireLoss(-0.5*REM, 0)
	M.adjustOxyLoss(-1*REM, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustEarDamage(-2*REM)
	for(var/obj/item/organ/filling_organ/forgan in M.internal_organs) //auto detected heal of filling organs
		M.adjustOrganLoss(forgan.slot, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/majorhealthpot
	name = "Major Health Potion"
	description = "Quickly regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff4800"
	taste_description = "red"
	overdose_threshold = 20 // Means you'll end up in critical condition and need outside help if you over do it.
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/majorhealthpot/on_mob_life(mob/living/carbon/M) // Triple the healing of regular health pots.
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+100, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+20, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		M.heal_wounds(4)
		M.update_damage_overlays()
	M.adjustBruteLoss(-1.5*REM, 0) // 20u = 150 points of healing.
	M.adjustFireLoss(-1.5*REM, 0)
	M.adjustOxyLoss(-3, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3*REM)
	for(var/obj/item/organ/filling_organ/forgan in M.internal_organs) //auto detected heal of filling organs
		M.adjustOrganLoss(forgan.slot, -1*REM)
	M.adjustCloneLoss(-3*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/majorhealthpot/overdose_process(mob/living/carbon/M) // Savor your supreme healing, or else.
	M.add_nausea(15)
	M.adjustBruteLoss(1*REM, 0)
	M.adjustToxLoss(3, 0)
	M.blood_volume = min(M.blood_volume+100, BLOOD_VOLUME_MAXIMUM) // Full to bursting.

/datum/chemical_reaction/sublime_ambrosia
	name = "Sublime Ambrosia"
	id = /datum/reagent/medicine/sublimeambrosia
	results = list(/datum/reagent/medicine/sublimeambrosia = 5)
	required_reagents = list (/datum/reagent/medicine/healthpot = 45, /datum/reagent/medicine/minorhealthpot = 45, /datum/reagent/medicine/majorhealthpot = 45)

/datum/reagent/medicine/sublimeambrosia
	name = "Sublime Ambrosia"
	description = "Rapidly regenerates all types of damage, and reverses death."
	reagent_state = LIQUID
	color = "#b89c2b"
	taste_description = "magical apoptosis"
	overdose_threshold = 6 // Small doses...
	metabolization_rate = 0.3 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/sublimeambrosia/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+200, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+20, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		M.heal_wounds(6)
		M.update_damage_overlays()
	M.adjustBruteLoss(-4.5*REM, 0)
	M.adjustFireLoss(-4.5*REM, 0)
	M.adjustOxyLoss(-9, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -9*REM)
	M.adjustCloneLoss(-9*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/sublimeambrosia/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(iscarbon(M) && M.stat == DEAD)
		if(M.mob_biotypes & MOB_UNDEAD)
			return FALSE
		if(!M.revive(full_heal = FALSE))
			M.visible_message(span_notice("[M]'s body does not seem to react to the ambrosia..."))
			return FALSE
		if(method == INGEST)
			var/mob/living/carbon/spirit/underworld_spirit = M.get_spirit()
			if(underworld_spirit)
				var/mob/dead/observer/ghost = underworld_spirit.ghostize()
				qdel(underworld_spirit)
				ghost.mind.transfer_to(M, TRUE)
			M.grab_ghost(force = TRUE) // even suicides
			M.emote("breathgasp")
			M.Jitter(100)
			M.update_body()
			M.visible_message(span_notice("[M]'s body convulses as they're ripped from death's embrace by ambrosia!"), span_green("I awake from the void."))
			if(M.mind)
				if(!HAS_TRAIT(M, TRAIT_IWASREVIVED))
					ADD_TRAIT(M, TRAIT_IWASREVIVED, "[type]")
		return TRUE
	..()

/datum/reagent/medicine/sublimeambrosia/overdose_process(mob/living/carbon/M) // This is meant for the dead, or near dead. Imbibe at own risk.
	M.add_nausea(25)
	M.adjustBruteLoss(3*REM, 0)
	M.dizziness += 2
	M.confused += 2
	M.adjustToxLoss(15, 0)
	M.blood_volume = min(M.blood_volume+100, BLOOD_VOLUME_MAXIMUM)

/datum/reagent/medicine/shroomt
	name = "Shroom Tea"
	description = "Extremely slowly regenerates all types of damage. long lasting."
	reagent_state = LIQUID
	color = "#476e4d"
	taste_description = "dirt"
	overdose_threshold = 25 // cups hold 24 so even one sip more from tanakrd is OD
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/shroomt/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+2, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		M.heal_wounds(1)
		M.update_damage_overlays()
	M.adjustBruteLoss(-0.2*REM, 0)
	M.adjustToxLoss(-0.2*REM, 0)
	M.adjustFireLoss(-0.2*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.rogstam_add(25)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/shroomt/overdose_process(mob/living/carbon/M)
	M.add_nausea(15)

/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#0000ff"
	taste_description = "manna"
	overdose_threshold = 0
	metabolization_rate = 20 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(100)
	..()
	. = 1

/datum/reagent/medicine/antipregnancy
	name = "Pregnancy Removal Potion"
	description = "Fixes mistakes."
	reagent_state = LIQUID
	color = "#a9326a"
	taste_description = "worries"
	overdose_threshold = 60
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 200

/datum/reagent/medicine/antipregnancy/on_mob_life(mob/living/carbon/M)
	if(istype(holder, /obj/item/organ/filling_organ))
		var/obj/item/organ/filling_organ/forgan = holder
		if(forgan.pregnant)
			forgan.undo_preggoness()
	M.add_nausea(0.2)
	..()
	. = 1

/datum/reagent/medicine/antipregnancy/overdose_process(mob/living/carbon/M)
	M.add_nausea(9)
	M.adjustToxLoss(3, 0)

/datum/reagent/medicine/antipoisonpot
	name = "Anti Poison Potion"
	description = "Quickly nullifies toxins."
	reagent_state = LIQUID
	color = "#64bf49"
	taste_description = "ashes"
	overdose_threshold = 60
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 200

/datum/reagent/medicine/antipoisonpot/on_mob_life(mob/living/carbon/M)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,0.5)
	M.adjustToxLoss(-0.5*REM, 0)
	if(M.has_status_effect(STATUS_EFFECT_ENDOWED))
		M.remove_status_effect(STATUS_EFFECT_ENDOWED)
	..()
	. = 1

/datum/reagent/medicine/antipoisonpot/overdose_process(mob/living/carbon/M)
	M.add_nausea(9)
	M.adjustToxLoss(3, 0)

/datum/reagent/berrypoison
	name = "Berry Poison"
	description = "Contains a poisonous thick, dark purple liquid."
	reagent_state = LIQUID
	color = "#00B4FF"
	metabolization_rate = 0.1

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER || TRAIT_WILD_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = "A viscous black liquid clings to the glass."
	reagent_state = LIQUID
	color = "#ff2f00"
	metabolization_rate = 0.1

/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER) && !HAS_TRAIT(M, TRAIT_ORGAN_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()


/datum/reagent/infection
	name = "excess choleric humour"
	description = "Red-yellow pustulence - the carrier of disease, the enemy of all Pestrans."
	reagent_state = LIQUID
	color = "#dfe36f"
	metabolization_rate = 0.1
	var/damage_tick = 0.3
	var/lethal_fever = FALSE
	var/fever_multiplier = 1

/datum/reagent/infection/on_mob_life(mob/living/carbon/M)
	var/heat = (BODYTEMP_AUTORECOVERY_MINIMUM + clamp(volume, 3, 15)) * fever_multiplier
	M.adjustToxLoss(damage_tick, 0)
	if (lethal_fever)
		M.adjust_bodytemperature(heat, 0)
		if (prob(5))
			to_chat(M, span_warning("A wicked heat settles within me... I feel ill. Very ill."))
	else
		M.adjust_bodytemperature(heat, 0, BODYTEMP_HEAT_DAMAGE_LIMIT - 1)
		if (prob(5))
			to_chat(M, span_warning("I feel a horrible chill despite the sweat rolling from my brow..."))
	return ..()

/datum/reagent/infection/minor
	name = "disrupted choleric humor"
	description = "Symptomatic of disrupted humours."
	damage_tick = 0.1
	lethal_fever = FALSE

/datum/reagent/infection/major
	name = "excess melancholic humour"
	description = "Kingsfield's Bane. Excess melancholic has killed thousands, and even Pestra's greatest struggle against its insidious advance."
	damage_tick = 1
	lethal_fever = TRUE
	fever_multiplier = 3

/datum/reagent/infection/major/on_mob_life(mob/living/carbon/M)
	if (M.badluck(1))
		M.reagents.add_reagent(src, rand(1,3))
		to_chat(M, span_small("I feel even worse..."))
	return ..()
