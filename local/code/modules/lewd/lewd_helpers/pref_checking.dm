/**
 * Checks to see if the parent mob has `pref_to_check` enabled, returns `FALSE` if the pref cannot be found or is set to False, otherwise returns `TRUE`
 *
 * This proc should be used when checking direct one-time interactions where logging would be benefical.
 * If you don't need to use logging, please use the `read_preference` proc
 *
 * Arguments
 * * `pref_to_check` - The toggle preference that we want to check to make sure works.
 * * `mechanic_user` - The person using the erp mechanic on the parent mob?
 * * `used_item` - What item, if any, is being used on the parent mob?
 */
/mob/living/proc/check_erp_prefs(datum/preference/toggle/pref_to_check, mob/living/mechanic_user = null, obj/item/used_item = FALSE)
	if(!ispath(pref_to_check))
		return FALSE

	if(client?.prefs?.read_preference(pref_to_check))
		return TRUE // We are good to go!

	if(!client?.prefs || (mechanic_user == src))
		return FALSE // Clients are a fickle mistress, but also no need for any further checks if someone is doing it on themselves without the prefs to allow it.

	var/message_to_log = "[src] had an ERP mechanic attempted to be used on them while their prefs were disabled"
	if(used_item)
		message_to_log = "[used_item] was attempted to be used on [src] while their prefs were disabled"

	var/turf/parent_turf = get_turf(src)
	if(parent_turf)
		message_to_log += " at [loc_name(parent_turf)]"

	if(mechanic_user)
		message_to_log += ", by [mechanic_user]"

	log_message(message_to_log + ".", LOG_GAME)

	return FALSE
