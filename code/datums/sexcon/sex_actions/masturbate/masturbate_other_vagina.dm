/datum/sex_action/masturbate_other_vagina
	name = "Stroke their clit"
	check_same_tile = FALSE

/datum/sex_action/masturbate_other_vagina/shows_on_menu(mob/living/user, mob/living/target)
	if(!target.erpable && issimple(target))
		return FALSE
	if(user.client.prefs.defiant && issimple(target))
		return FALSE
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		if(issimple(target) && target.gender == FEMALE && target.sexcon)
		else
			return FALSE
	return TRUE

/datum/sex_action/masturbate_other_vagina/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/targethuman = target
		if(targethuman.wear_pants)
			var/obj/item/clothing/under/roguetown/pantsies = targethuman.wear_pants
			if(pantsies.flags_inv & HIDECROTCH)
				if(!pantsies.genitalaccess)
					return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		if(issimple(target) && target.gender == FEMALE && target.sexcon)
		else
			return FALSE
	return TRUE

/datum/sex_action/masturbate_other_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY))) //Fairy on non-fairy will be fucking, otherwise normal
		//Stroking becomes finger fucking instead
		user.visible_message(span_warning("[user] starts fucking [target]'s cunt with their finger..."))
	else
		user.visible_message(span_warning("[user] starts stroking [target]'s clit..."))

/datum/sex_action/masturbate_other_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY))) //Fairy on non-fairy will be fucking, otherwise normal
			//Stroking becomes finger fucking instead
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s cunt with their finger..."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] strokes [target]'s clit..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_other_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(target, TRAIT_TINY) && !(HAS_TRAIT(user, TRAIT_TINY))) //Fairy on non-fairy will be fucking, otherwise normal
		user.visible_message(span_warning("[user] stops fucking [target]'s cunt with their finger."))
	else
		user.visible_message(span_warning("[user] stops stroking [target]'s clit."))

/datum/sex_action/masturbate_other_vagina/is_finished(mob/living/user, mob/living/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE

//fingering

/datum/sex_action/masturbate_other_vaginatwo
	name = "Finger their cunt"
	check_same_tile = FALSE

/datum/sex_action/masturbate_other_vaginatwo/shows_on_menu(mob/living/user, mob/living/target)
	if(!target.erpable && issimple(target))
		return FALSE
	if(user.client.prefs.defiant && issimple(target))
		return FALSE
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		if(issimple(target) && target.gender == FEMALE && target.sexcon)
		else
			return FALSE
	return TRUE

/datum/sex_action/masturbate_other_vaginatwo/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/targethuman = target
		if(targethuman.wear_pants)
			var/obj/item/clothing/under/roguetown/pantsies = targethuman.wear_pants
			if(pantsies.flags_inv & HIDECROTCH)
				if(!pantsies.genitalaccess)
					return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		if(issimple(target) && target.gender == FEMALE && target.sexcon)
		else
			return FALSE
	return TRUE

/datum/sex_action/masturbate_other_vaginatwo/on_start(mob/living/user, mob/living/target)
	user.visible_message(span_warning("[user] starts fingering [target]'s cunt..."))

/datum/sex_action/masturbate_other_vaginatwo/on_perform(mob/living/user, mob/living/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fingers  [target]'s cunt..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_other_vaginatwo/on_finish(mob/living/user, mob/living/target)
	user.visible_message(span_warning("[user] stops fingering [target]'s cunt."))

/datum/sex_action/masturbate_other_vaginatwo/is_finished(mob/living/user, mob/living/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
