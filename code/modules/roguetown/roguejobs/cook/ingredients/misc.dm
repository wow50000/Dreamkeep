
/obj/item/reagent_containers/food/snacks/rogue/raisins
	name = "raisins"
	desc = "A handful of sweet, dried grape raisins."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "raisins5"
	bitesize = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("dried fruit" = 1)
	foodtype = GRAIN
	eat_effect = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/raisins/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "raisins4"
	if(bitecount == 2)
		icon_state = "raisins3"
	if(bitecount == 3)
		icon_state = "raisins2"
	if(bitecount == 4)
		icon_state = "raisins1"

/obj/item/reagent_containers/food/snacks/rogue/raisins/CheckParts(list/parts_list, datum/crafting_recipe/R)
	..()
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		color = M.filling_color
		if(M.reagents)
			M.reagents.remove_reagent(/datum/reagent/consumable/nutriment, M.reagents.total_volume)
			M.reagents.trans_to(src, M.reagents.total_volume)
		qdel(M)


/obj/item/reagent_containers/food/snacks/rogue/cheese
	name = "cheese"
	desc = "A ball of unaged farmer's cheese, plain but pleasant."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "freshcheese"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	foodtype = GRAIN
	eat_effect = null
	rotprocess = 20 MINUTES
	become_rot_type = null
	slice_path = null

/obj/item/reagent_containers/food/snacks/rogue/mothercheese
	name = "breastmilk cheese"
	desc = "A ball of cheese with a similar consistency to feta, consumed as part of certain Eoran fertility rites, or more rarely as a private indulgence between partners."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "freshcheese"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	foodtype = GRAIN
	eat_effect = null
	rotprocess = 20 MINUTES
	become_rot_type = null
	slice_path = null
	tastes = list("soft cheese" = 1)

/obj/item/reagent_containers/food/snacks/rogue/cheddar
	name = "wheel of cheddar"
	desc = "A golden wheel of cheddar cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "cheesewheel"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = 6
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddar/aged

/obj/item/reagent_containers/food/snacks/rogue/mothercheese/wheel
	name = "wheel of breastmilk cheese"
	desc = "A pale wheel of breastmilk cheese, typically left to cure for long-term storage."
	icon_state = "blue_cheese"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = 6
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/wedge
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/wheel/aged

/obj/item/reagent_containers/food/snacks/rogue/cheddar/aged
	name = "wheel of aged cheese"
	desc = "A wheel with intricate patterns of several types of mold with a pungent aroma."
	icon_state = "blue_cheese_wheel"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/mothercheese/wheel/aged
	name = "wheel of cured breastmilk cheese"
	desc = "A shelf-stable wheel of breastmilk cheese that has developed a mild-tasting yellow rind"
	icon_state = "cheesewheel"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/wedge/aged
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge
	name = "wedge of cheese"
	desc = "An invigorating wedge of cheddar cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "cheese_wedge"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = 3
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	baitchance = 100
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)

/obj/item/reagent_containers/food/snacks/rogue/mothercheese/wedge
	name = "wedge of breastmilk cheese"
	desc = "An sweet-tasting wedge of breastmilk milk cheese"
	icon_state = "mothercheese_wedge"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = 3
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/slice
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/wedge/aged

/obj/item/reagent_containers/food/snacks/rogue/cheddarwedge/aged
	name = "wedge of aged cheese"
	desc = "A dangerous piece of cheese for the brave."
	icon_state = "blue_cheese_wedge"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/mothercheese/wedge/aged
	name = "wedge of cured breastmilk cheese"
	desc = "A wedge of breastmilk cheese that has developed a mild-tasting yellow rind. It is sometimes consumed by middle-aged women who are seeking heightened fertility."
	icon_state = "cheese_wedge"
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/slice/aged
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice
	name = "slice of cheese"
	desc = "A soft, creamy slice of cheddar cheese."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "cheese_slice"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = null
	slice_path = null
	become_rot_type = null
	baitchance = 100
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 10,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5)

/obj/item/reagent_containers/food/snacks/rogue/mothercheese/slice
	name = "slice of breastmilk cheese"
	desc = "A soft, sweet slice of breast milk cheese."
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("cheese" = 1)
	eat_effect = null
	rotprocess = 20 MINUTES
	slices_num = null
	slice_path = null
	become_rot_type = /obj/item/reagent_containers/food/snacks/rogue/mothercheese/slice/aged
	icon_state = "mothercheese_slice"

/obj/item/reagent_containers/food/snacks/rogue/cheddarslice/aged
	name = "slice of aged cheese"
	desc = "A dangerous slice of cheese."
	icon_state = "blue_cheese_slice"
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/mothercheese/slice/aged
	name = "slice of cured breastmilk cheese"
	desc = "A golden slice of breast milk cheese."
	icon_state = "cheese_slice"
	become_rot_type = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/honey
	name = "honey"
	desc = "Golden honey rich with the aroma of floral nectar."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "honey"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("sweetness and light" = 1)
	eat_effect = null
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/mashedpotatoes
	name = "mashed potatoes"
	desc = "A bowl of mashed potatoes."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "mashedpotatoes"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("creamy and light" = 1)
	eat_effect = null
	rotprocess = null
