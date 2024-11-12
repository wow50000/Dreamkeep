/// potions and tinctures

/datum/crafting_recipe/roguetown/alchemy
	req_table = FALSE
	verbage_simple = "mix"
	skillcraft = /datum/skill/misc/alchemy
	subtype_reqs = TRUE
	structurecraft = /obj/structure/fluff/alch

/datum/crafting_recipe/roguetown/alchemy/thermometer
	name = "Thermoscope"
	result = list(/obj/item/thermometer)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /datum/reagent/mercury = 5)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/bbomb
	name = "Bottle bomb"
	result = list(/obj/item/bomb)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/ash = 2, /obj/item/rogueore/coal = 1, /obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/ozium
	name = "Ozium Poppy"
	result = list(/obj/item/reagent_containers/food/snacks/grown/poppy)
	reqs = list(/obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/puremoon
	name = "Purest Moondust"
	result = list(/obj/item/reagent_containers/powder/moondust/purest)
	reqs = list(/obj/item/reagent_containers/powder/moondust, /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 1, /datum/reagent/berrypoison = 5)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/spice
	name = "Spice Melange"
	result = list(/obj/item/reagent_containers/powder/spice)
	reqs = list(/obj/item/ash = 1, /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry = 1, /datum/reagent/berrypoison = 5)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/salt
	name = "Salt Pile"
	result = list(/obj/item/reagent_containers/powder/salt)
	reqs = list(/obj/item/ash = 1, /datum/reagent/water = 10, /obj/item/reagent_containers/food/snacks/fat = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/salt_2
	name = "Salt Pile"
	result = list(/obj/item/reagent_containers/powder/salt)
	reqs = list(/obj/item/ash = 1, /datum/reagent/water = 10, /obj/item/reagent_containers/food/snacks/rogue/meat/mince = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/manna_pot
	name = "Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/manna_pot_3x
	name = "3x Manna Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/manapot,/obj/item/reagent_containers/glass/bottle/rogue/manapot,/obj/item/reagent_containers/glass/bottle/rogue/manapot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/powder/sublimate = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/minorhealthpot
	name = "Minor Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1,
		/obj/item/ash = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/minorhealthpot3x
	name = "3x Minor Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/minorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 2,
		/obj/item/ash = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/healthpot
	name = "Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1,
		/obj/item/ash = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/healthpot3x
	name = "3x Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot,/obj/item/reagent_containers/glass/bottle/rogue/healthpot,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2,
		/obj/item/ash = 2)
	craftdiff = 2

//fuck fish
/datum/crafting_recipe/roguetown/alchemy/healthpot3xalt
	name = "3x Health Potion (Honey)"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot,/obj/item/reagent_containers/glass/bottle/rogue/healthpot,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/food/snacks/rogue/honey = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/majorhealthpot
	name = "Major Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/ash = 1,
		/obj/item/natural/bone = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/majorhealthpot3x
	name = "3x Major Health Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot,/obj/item/reagent_containers/glass/bottle/rogue/majorhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/food/snacks/grown/apple = 2,
		/obj/item/ash = 2,
		/obj/item/natural/bone = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/sublimeambrosia
	name = "Sublime Ambrosia Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/sublimeambrosia)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/datum/reagent/medicine/minorhealthpot = 45,
		/datum/reagent/medicine/healthpot = 45,
		/datum/reagent/medicine/majorhealthpot = 45,
		/obj/item/ash = 1,
		/obj/item/reagent_containers/powder/sublimate = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/sublimeambrosia3x
	name = "3x Sublime Ambrosia Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/sublimeambrosia, /obj/item/reagent_containers/glass/bottle/rogue/sublimeambrosia, /obj/item/reagent_containers/glass/bottle/rogue/sublimeambrosia)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/datum/reagent/medicine/minorhealthpot = 15,
		/datum/reagent/medicine/healthpot = 15,
		/datum/reagent/medicine/majorhealthpot = 15,
		/obj/item/reagent_containers/powder/mfire = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/alchemy/antipoison_pot
	name = "Anti Poison Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/antipoison_pot_3x
	name = "3x Anti Poison Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot,/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot,/obj/item/reagent_containers/glass/bottle/rogue/antipoisonpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/powder/sublimate = 2,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/antipreg_pot
	name = "Sterility Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/antipregnancy)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 1, /obj/item/reagent_containers/powder/crystalglass = 1, /obj/item/clothing/head/peaceflower = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/antipreg_pot_3x
	name = "3x Sterility Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/antipregnancy,/obj/item/reagent_containers/glass/bottle/rogue/antipregnancy,/obj/item/reagent_containers/glass/bottle/rogue/antipregnancy)
	reqs = list(/obj/item/reagent_containers/glass/bottle = 3, /obj/item/reagent_containers/powder/crystalglass = 2, /obj/item/clothing/head/peaceflower = 2)
	craftdiff = 1

/// bottle craft


/datum/crafting_recipe/roguetown/alchemy/glassbottles
	name = "2x glass bottles"
	result = list(/obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/bottle)
	reqs = list(
		/obj/item/natural/stone = 1,
		/obj/item/natural/dirtclod = 1)
	craftdiff = 1
	verbage_simple = "forge"

/// transmutation

/datum/crafting_recipe/roguetown/alchemy/distill
	name = "distill water"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/water = 1)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/datum/reagent/water = 99) // 45 and 90 u allows for bottle duping. This requires 33oz containers, preventing the dupe.
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/w2m
	name = "transmute water to milk"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/milk = 1)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/datum/reagent/water = 99) // 45 and 90 u allows for bottle duping. This requires 33oz containers, preventing the dupe.
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/w2w
	name = "transmute water to wine" /// eat your heart out god.
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/wine = 1)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/datum/reagent/water = 99) // 45 and 90 u allows for bottle duping. This requires 33oz containers, preventing the dupe.
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/g2wes
	name = "transmute grain to westleach"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/w2swa
	name = "transmute westleach to swampweed"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/f2gra
	name = "transmute fiber to grain"
	result = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 1)
	reqs = list(/obj/item/natural/fibers = 4)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/b2app
	name = "transmute berry to apple"
	result = list(/obj/item/reagent_containers/food/snacks/grown/apple = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/poisonberry
	name = "corrupt berry"
	result = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 1, /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/safeberry
	name = "purify berry"
	result = list(/obj/item/reagent_containers/food/snacks/grown/rogue = 1)
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 1, /obj/item/reagent_containers/food/snacks/grown/herbs = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/w2coa
	name = "transmute small log to coal"
	result = list(/obj/item/rogueore/coal = 1)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/alchemy/w2l
	name = "combine small logs into large log"
	result = list(/obj/item/grown/log/tree = 1)
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/natural/fibers)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/l2coa
	name = "transmute log to coal"
	result = list(/obj/item/rogueore/coal = 4)
	reqs = list(/obj/item/grown/log/tree = 1)
	craftdiff = 1
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/alchemy/s2coa
	name = "transmute stone to coal"
	result = list(/obj/item/rogueore/coal = 1)
	reqs = list(/obj/item/natural/stone = 4)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/coa2s
	name = "transmute coal to stones"
	result = list(/obj/item/natural/stone = 4)
	reqs = list(/obj/item/rogueore/coal = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/c2irn
	name = "transmute coal to iron"
	result = list(/obj/item/rogueore/iron = 1)
	reqs = list(/obj/item/rogueore/coal = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/i2gol
	name = "transmute iron to gold"
	result = list(/obj/item/rogueore/gold = 1)
	reqs = list(/obj/item/rogueore/iron = 4)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/i2top // Keep topers and their trinkets cheap to prevent wealth creep. Cheap means of getting gem dust, for potions.
	name = "transmute iron to toper"
	result = list(/obj/item/roguegem/yellow = 1)
	reqs = list(
		/obj/item/rogueore/iron = 1, //Toper will be worth 30 mammon. Iron ingot is worth 25.
		/obj/item/natural/stone = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/alglass // TO-DO: add construction recipe for church windows using this. Touching a church window with mage hand will invert it to the evil version and vice versa.
	name = "transmute stone to alchemical glass"
	result = list(/obj/item/roguegem = 1)
	reqs = list(
		/obj/item/reagent_containers/powder/sublimate = 1,
		/obj/item/natural/stone = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/t2gem
	name = "transmute topaz to emerald"
	result = list(/obj/item/roguegem/green = 1)
	reqs = list(
		/obj/item/roguegem/yellow = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/g2saf
	name = "transmute emerald to sapphire"
	result = list(/obj/item/roguegem/violet = 1)
	reqs = list(
		/obj/item/roguegem/green = 1,
		/obj/item/roguegem/yellow = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/s2blo
	name = "transmute sapphire to turquise"
	result = list(/obj/item/roguegem/blue = 1)
	reqs = list(
		/obj/item/roguegem/violet = 1,
		/obj/item/roguegem/yellow = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/b2ron
	name = "transmute turquoise to ruby"
	result = list(/obj/item/roguegem/red = 1)
	reqs = list(
		/obj/item/roguegem/blue = 1,
		/obj/item/roguegem/yellow = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/r2dia
	name = "transmute ruby to diamond"
	result = list(/obj/item/roguegem/diamond = 1)
	reqs = list(
		/obj/item/roguegem/red = 1,
		/obj/item/roguegem/yellow = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/d2ros
	name = "transmute diamonds to riddle of steel" /// holy grail requires legendary. (sell price on average is 350. ruby and diamond worth 100 each. you get to legndary you deserve 150-200 profit)
	result = list(/obj/item/riddleofsteel = 1)
	reqs = list(
		/obj/item/roguegem/diamond = 1,
		/obj/item/rogueore/iron = 3, //3 iron and 1 coal, same as the ratio of materials in a greatforge.
		/obj/item/rogueore/coal = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/alchemy/e2s
	name = "transmute steel to silver" // Making it is still pretty involved, but at least now you aren't wasting 3 entire ingots of steel plus almost 300 mammon worth of potential profit for a single silver ingot.
	result = list(/obj/item/ingot/silver = 4)
	reqs = list(/obj/item/rogueore/gold = 2, /obj/item/ingot/steel = 4, /obj/item/roguegem/violet = 2)
	craftdiff = 6

/datum/crafting_recipe/roguetown/alchemy/moon
	name = "Moondust"
	result = list(/obj/item/reagent_containers/powder/moondust)
	reqs = list(
		/obj/item/ash = 1,
		/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 2) // Probably better to just buy from the merchant.
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/t2sub
	name = "Sublimate Topaz Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/toper = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/g2sub
	name = "Sublimate Emerald Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/gemerald = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/s2sub
	name = "Sublimate Sapphire Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/saffira = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/b2sub
	name = "Sublimate Quartz Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/blortz = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/r2sub
	name = "Sublimate Ruby Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/rontz = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/d2sub
	name = "Sublimate Diamond Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,)
	reqs = list(
		/obj/item/reagent_containers/powder/dorpel = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/m2sub
	name = "Sublimate Malum's Fire"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,)
	reqs = list(
		/obj/item/reagent_containers/powder/mfire = 1,
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1
