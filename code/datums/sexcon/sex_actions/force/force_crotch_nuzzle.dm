/datum/sex_action/force_crotch_nuzzle
	name = "Fuck them to nuzzle"

/datum/sex_action/force_crotch_nuzzle/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/force_crotch_nuzzle/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/force_crotch_nuzzle/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] slides his cock into [target]'s throat!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/force_crotch_nuzzle/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to suck his cock."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("cums into [target]'s throat!"))
		user.sexcon.cum_into()

	user.sexcon.perform_sex_action(target, 0, 7, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_crotch_nuzzle/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] pulls his cock out of [target]'s throat."))

/datum/sex_action/force_crotch_nuzzle/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.just_ejaculated())
		return TRUE
	return FALSE
