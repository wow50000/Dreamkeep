// Might as well go and group it up into a subsystem.

// Y'know, on a downstream you can go ahead and set it to whatever the fuck you want
#define AGE_TO_PLAY 18

#define AGE_CHECK_INVALID 0
#define AGE_CHECK_UNDERAGE 1
#define AGE_CHECK_PASSED 2

SUBSYSTEM_DEF(maturity_guard)
	name = "Maturity guard"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_MATURITY_GUARD
	/// A list of currently active prompts.
	var/list/prompt_cache = list()
	/// A list of players that failed the age check this round. Stopgap only used if we don't have a db attached to ban people.
	var/list/blacklisted_cache = list()

	/// Current year, stored on the subsystem init
	var/current_year
	/// Current month of the year, stored on the subsystem init
	var/current_month
	/// Current day of the month, stored on the subsystem init
	var/current_day


/datum/controller/subsystem/maturity_guard/Initialize()
	var/current_time = world.realtime
	current_day = text2num(time2text(current_time, "DD"))
	current_month = text2num(time2text(current_time, "MM"))
	current_year = text2num(time2text(current_time, "YYYY"))
	. = ..()

/**
 * Checks if the player is declared of age. Prompts the player for DoB if necessary.
 */
/datum/controller/subsystem/maturity_guard/proc/age_check(mob/user, href_list[])

	// Well, if there's no checks meant to be made, everyone automatically passes.
	if(!CONFIG_GET(flag/age_prompt_system))
		return TRUE
	if(!SSmaturity_guard.initialized) // To prevent false bans, we dont let people use the prompt until the subsystem is initialized.
		return FALSE
	if(!SSdbcore.Connect() && (user.ckey in blacklisted_cache))
		qdel(user.client)
		return FALSE
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(isnull(user.client))
		return FALSE

	var/user_ckey = user.ckey
	var/age_from_db = get_age_from_db(user)
	if(age_from_db && validate_dob(age_from_db[1], age_from_db[2], simple_check=TRUE) == AGE_CHECK_PASSED)
		user.client.maturity_prompt_whitelist = TRUE
		return TRUE
	if(href_list["age_prompt"])
		var/year = text2num(href_list["year"])
		var/month = text2num(href_list["month"])
		var/day = text2num(href_list["day"])
		var/check_result = validate_dob(year, month, day)
		switch(check_result)
			if(AGE_CHECK_INVALID)
				to_chat_immediate(user, "<span class='warning'>Invalid information entered. Please try again.</span>")
				user.client.OpenMaturityPrompt()
				return FALSE
			if(AGE_CHECK_UNDERAGE)
				create_underage_ban(user)
				return FALSE
			if(AGE_CHECK_PASSED)
				add_age_to_db(user, year, month)
				user.client.maturity_prompt_whitelist = TRUE
				user.client.CloseMaturityPrompt()
				return TRUE
	else
		if(!(user.ckey in prompt_cache))
			prompt_cache |= user_ckey
			user.client.OpenMaturityPrompt()
		else
			to_chat_immediate(user, "<span class='warning'>Please enter your date of birth.</span>")
			user.client.OpenMaturityPrompt()
		return FALSE

	// var/datum/maturity_prompt/prompt = new(user, 60 SECONDS, GLOB.always_state)
	// prompt.ui_interact(user)
	// prompt.wait()
	// prompt_cache -= user_ckey
	// if(prompt)
	// 	. = list(prompt.year, prompt.month, prompt.day)

	// 	var/check_result = validate_dob(prompt.year, prompt.month, prompt.day)
	// 	switch(check_result)
	// 		if(AGE_CHECK_INVALID)
	// 			to_chat_immediate(user, "<span class='warning'>Invalid information entered. Please try again.</span>")
	// 		if(AGE_CHECK_UNDERAGE)
	// 			create_underage_ban(user)
	// 		if(AGE_CHECK_PASSED)
	// 			add_age_to_db(user, prompt.year, prompt.month)
	// 			user.client.maturity_prompt_whitelist = TRUE
	// 	qdel(prompt)


/datum/controller/subsystem/maturity_guard/proc/get_age_from_db(mob/user)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!SSdbcore.Connect())
		return FALSE

	if(!istype(user) || !user.ckey)
		return FALSE

	var/datum/DBQuery/query_age_from_db = SSdbcore.NewQuery(
		"SELECT dob_year, dob_month FROM [format_table_name("player_dob")] WHERE ckey = :ckey",
		list("ckey" = user.ckey),
	)

	if(!query_age_from_db.warn_execute())
		return FALSE

	// There should be only one, we're querying by the primary key; if it returns more than one row something is very wrong
	var/result = query_age_from_db.NextRow()
	if(result)
		qdel(query_age_from_db)
		return query_age_from_db.item
	qdel(query_age_from_db)
	return FALSE


/datum/controller/subsystem/maturity_guard/proc/add_age_to_db(mob/user, year, month)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!SSdbcore.Connect())
		return FALSE

	if(!istype(user) || !user.ckey)
		return FALSE

	if(!isnum(year) || !isnum(month))
		return FALSE

	var/datum/DBQuery/add_age_to_db = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("player_dob")] (ckey, dob_year, dob_month) VALUES(:ckey, :dob_year, :dob_month) \
		 ON DUPLICATE KEY UPDATE dob_year = :dob_year, dob_month = :dob_month",
		list("ckey" = user.ckey, "dob_year" = year, "dob_month" = month),
	)

	if(!add_age_to_db.warn_execute())
		qdel(add_age_to_db)
		return FALSE

	qdel(add_age_to_db)
	return TRUE

// Logic inspired by S.P.L.U.R.T age_gate
// https://github.com/SPLURT-Station/S.P.L.U.R.T-Station-13/blob/6e6bce87726b7a5ac7ebf23bec7b020a004c6e60/code/modules/mob/dead/new_player/new_player.dm
/datum/controller/subsystem/maturity_guard/proc/validate_dob(player_year, player_month, player_day, simple_check = FALSE)
	//Rudimentary sanity check
	if(!isnum(player_year) || !isnum(player_month))
		return AGE_CHECK_INVALID
	
	if(!simple_check && !isnum(player_day))
		return AGE_CHECK_INVALID

	if(player_year >= current_year || player_year <= 1900 || player_month < 1 || player_month > 12)
		return AGE_CHECK_INVALID

	var/player_total_months = (player_year * 12) + player_month
	var/current_total_months = (current_year * 12) + current_month
	var/months_in_required_age = AGE_TO_PLAY * 12

	var/month_difference = current_total_months - player_total_months
	if(month_difference > months_in_required_age)
		return AGE_CHECK_PASSED

	if(month_difference < months_in_required_age)
		return AGE_CHECK_UNDERAGE

	// We're assuming the data we're operating on has already undergone a more rigorous check
	if(simple_check)
		return AGE_CHECK_PASSED

	//they could be 17 or 18 depending on the /day/ they were born in
	var/days_in_months = list(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
	if((player_year % 4) == 0) // leap year so february actually has 29 days
		days_in_months[2] = 29
	var/total_days_in_player_month = days_in_months[player_month]

	if(player_day < 1 || player_day > total_days_in_player_month)
		return AGE_CHECK_INVALID

	if(player_day <= current_day)
		//their birthday has passed
		return AGE_CHECK_PASSED
	else
		//it has NOT been their 18th birthday yet
		return AGE_CHECK_UNDERAGE

// I hate this abomination
/// Because apparently there's no simple proc for applying bans and admin datums need an actual admin holding them
/datum/controller/subsystem/maturity_guard/proc/create_underage_ban(mob/user)
	if(IsAdminAdvancedProcCall())
		return

	var/discord_appeal_text = ""
	if(CONFIG_GET(string/discordurl))
		discord_appeal_text = "If you believe this to be a mistake, file an appeal in our community. <a href='[CONFIG_GET(string/discordurl)]>[CONFIG_GET(string/discordurl)]</a>"
	var/player_ban_notification = "<span class='boldannounce'>You have been banned by the AGE CHECK SYSTEM from the server.\nReason: You do not meet the minimum age requirements for this community. [discord_appeal_text]</span>"

	if(!SSdbcore.Connect())
	 	// Just a stopgap measure... this really isn't intended to be used without a db attached
		message_admins("[user.ckey] has FAILED THE AGE CHECK but couldn't be banned due to lack of database connection.")
		blacklisted_cache |= user.ckey
		to_chat(user, player_ban_notification)
		qdel(user.client)
		return

	if(!istype(user) || !user.ckey)
		return

	var/list/clients_online = GLOB.clients.Copy()
	var/list/admins_online = list()
	for(var/client/C in clients_online)
		if(C.holder) //deadmins aren't included since they wouldn't show up on adminwho
			admins_online += C
	var/who = clients_online.Join(", ")
	var/adminwho = admins_online.Join(", ")

	var/special_columns = list(
		"bantime" = "NOW()",
		"server_ip" = "INET_ATON(?)",
		"ip" = "INET_ATON(?)",
		"a_ip" = "INET_ATON(?)",
		"expiration_time" = "NULL"
	)

	var/sql_ban = list(
		"server_ip" = world.internet_address || 0,
		"server_port" = world.port,
		"round_id" = GLOB.round_id,
		"role" = "Server",
		"global_ban" = TRUE,
		"expiration_time" = null,
		"applies_to_admins" = TRUE,
		"reason" = "You do not meet the minimum age requirements for this community. If you believe this to be a mistake, file an appeal in our community.",
		"ckey" = user.ckey,
		"ip" = user.client.address,
		"computerid" = user.client.computer_id,
		"a_ckey" = "AGE CHECK SYSTEM",
		"a_ip" = 0,
		"a_computerid" = "N/A",
		"who" = who,
		"adminwho" = adminwho
	)

	if(!SSdbcore.MassInsert(format_table_name("ban"), list(sql_ban), warn = TRUE, special_columns = special_columns))
		return

	var/target = "[user.ckey]/[user.client.address]/[user.client.computer_id]"
	var/msg = "has created a global permanent server ban for [target]."
	log_admin_private("AGE CHECK SYSTEM [msg]")
	message_admins("AGE CHECK SYSTEM [msg]")

	to_chat(user, player_ban_notification)

	qdel(user.client)
