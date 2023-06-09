
-- add detection if he's not trapped, and if he's being trapped by some player, then attack him
combatMS = createCombatObject()--
setCombatParam(combatMS, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combatMS, COMBAT_PARAM_AGGRESSIVE, false)
conditionMS = createConditionObject(CONDITION_MANASHIELD)
setConditionParam(conditionMS, CONDITION_PARAM_TICKS, 200000)
setCombatCondition(combatMS, conditionMS)

combatBER = createCombatObject()--
setCombatParam(combatBER, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatBER, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combatBER, COMBAT_PARAM_USECHARGES, true)
areaBER = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combatBER, areaBER)
function onGetFormulaValueBER(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack, level / 5
	return -(skillTotal * 0.5 + levelTotal), -(skillTotal * 1.5 + levelTotal)
end
setCombatCallback(combatBER, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValueBER")

combatFBER = createCombatObject()--
setCombatParam(combatFBER, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatFBER, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combatFBER, COMBAT_PARAM_USECHARGES, true)
areaFBER = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combatFBER, areaFBER)
function onGetFormulaValuesFBER(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack * 2, level / 5
	return -(skillTotal * 1.1 + levelTotal), -(skillTotal * 3 + levelTotal)
end
setCombatCallback(combatFBER, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesFBER")

combatEMORT = createCombatObject()--
setCombatParam(combatEMORT, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combatEMORT, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combatEMORT, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
setCombatFormula(combatEMORT, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 5, 5, 1.4, 2.1)

combatETERRA = createCombatObject()--
setCombatParam(combatETERRA, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combatETERRA, COMBAT_PARAM_EFFECT, CONST_ME_CARNIPHILA)
setCombatParam(combatETERRA, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
setCombatFormula(combatETERRA, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 5, 5, 1.4, 2.1)

combatSPEAR = createCombatObject()
setCombatParam(combatSPEAR, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatSPEAR, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combatSPEAR, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
function onGetFormulaValuesSPEAR(cid, level, skill, attack, factor)
	return -(((skill + 25) / 3) + (level / 5)), -((skill + 25) + (level / 5))
end
setCombatCallback(combatSPEAR, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesSPEAR")

combatMELLETHROW = createCombatObject()--
setCombatParam(combatMELLETHROW, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatMELLETHROW, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combatMELLETHROW, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
setCombatParam(combatMELLETHROW, COMBAT_PARAM_USECHARGES, true)
function onGetFormulaValuesMELLETHROW(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack, level / 5
	return -(skillTotal / 3 + levelTotal), -(skillTotal + levelTotal)
end
setCombatCallback(combatMELLETHROW, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesMELLETHROW")

combatStrongHaste = createCombatObject()
setCombatParam(combatStrongHaste, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combatStrongHaste, COMBAT_PARAM_AGGRESSIVE, false)

conditionStrongHaste = createConditionObject(CONDITION_HASTE)
setConditionParam(conditionStrongHaste, CONDITION_PARAM_TICKS, 22000)
setConditionFormula(conditionStrongHaste, 0.7, -56, 0.7, -56)
setCombatCondition(combatStrongHaste, conditionStrongHaste)

combatHaste = createCombatObject()
setCombatParam(combatHaste, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combatHaste, COMBAT_PARAM_AGGRESSIVE, false)

conditionHaste = createConditionObject(CONDITION_HASTE)
setConditionParam(conditionHaste, CONDITION_PARAM_TICKS, 33000)
setConditionFormula(conditionHaste, 0.3, -24, 0.3, -24)
setCombatCondition(combatHaste, conditionHaste)

combatTS = createCombatObject()
setCombatParam(combatTS, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combatTS, COMBAT_PARAM_EFFECT, CONST_ME_BIGCLOUDS)
setAttackFormula(combatTS, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 5, 12)

areaTS = createCombatArea(AREA_CROSS6X6)
setCombatArea(combatTS, areaTS)


function onThink(cid)
	if((not isBot(cid) or isBotActive(cid)) and (getPlayerGUID(cid) % 120) == (os.time() % 120)) then
		db.executeQuery("UPDATE `players` SET `level` = " .. getPlayerLevel(cid) .. ", `kills` = " .. getFrags(cid) .. ", `tmp_kills` = " .. getTmpFrags(cid) .. ", `deaths` = " .. getDeaths(cid) .. ", `tmp_deaths` = " .. getTmpDeaths(cid) .. ", `assists` = " .. getAssists(cid) .. ", `tmp_assists` = " .. getTmpAssists(cid) .. "  WHERE `id` = " .. getPlayerGUID(cid) .. ";")
	end
	if(isPlayer(cid) and isBot(cid) and isBotActive(cid)) then
		local guid = getPlayerGUID(cid)
		local pos = getCreaturePosition(cid)

		updateInterval(guid)
		if(checkInterval(guid, 100)) then
			reduceDamageOverTime(cid)
		end
		local voc = getPlayerVocation(cid)
		if(not isExhaustHealing(guid) and (voc == 1 or voc == 2) and not getCreatureCondition(cid, CONDITION_MANASHIELD)) then
			setExhaustHealing(guid, 1000)
			doCombat(cid, combatMS, numberToVariant(cid))
			doCreatureSay(cid, "utamo vita", TALKTYPE_ORANGE_1)
		end
		if(checkInterval(guid, 2)) then
			useBestHealing(cid, guid)
		end

		local floorChanged = false
		if(not isCurrentFloor(guid, pos.z)) then
			setCurrentFloor(guid, pos.z)
			resetIgnored(guid)
			floorChanged = true
		elseif(checkInterval(guid, 5)) then
			updateIgnored(guid)
		end

		if(checkInterval(guid, 3) or floorChanged or getPossibleTargets(guid) == nil) then
			updatePossibleTargets(guid, pos)
			updateIgnored(guid)
		end

		
-- count the number of attackers and go into escape mode for a few seconds
		if(b_attackersLastSec[guid] == nil or checkInterval(guid, 10)) then
			b_attackersLastSec[guid] = {}
		else
			local atks = 0
			for _, i in pairs(b_attackersLastSec[guid]) do
				atks = atks + 1
			end
			-- or ((voc == 1 or voc == 2) and getCreatureMana(cid) < 300)
			if(atks >= 3 or (atks >= 2 and math.random(1,80) == 15)) then
				if(not isExhaustHealing(guid) and not getCreatureCondition(cid, CONDITION_HASTE)) then
					if(voc == 1 or voc == 2) then
						setExhaustHealing(guid, 1000)
						doCombat(cid, combatStrongHaste, numberToVariant(cid))
						doCreatureSay(cid, "utani gran hur", TALKTYPE_ORANGE_1)
					else
						setExhaustHealing(guid, 1000)
						doCombat(cid, combatHaste, numberToVariant(cid))
						doCreatureSay(cid, "utani hur", TALKTYPE_ORANGE_1)
					end
				end
				doPlayerSetTarget(cid, 0)
				setRunningAway(guid, 10)
			end
		end

		if(isChangeTargetRequired(cid, guid) and not isRunningAway(guid)) then -- has no goal or needs to look for a new one
			if(getCreatureTarget(cid) > 0) then
				doPlayerSetTarget(cid, 0) -- check if it removes the target, it MUST - otherwise it won't kill people it can't hurt
			end
			local targets = getPossibleTargets(guid)
			while(#targets > 0) do
				local minDist = 15
				local targetID = 0
				local targetTableID = 0
				for i, pid in pairs(targets) do
					if(isCreature(pid)) then
						local tpos = getThingPosition(pid)
						if(isIgnored(guid, pid) or pid == cid or isNpc(pid) or getTileInfo(tpos).protection or getTileInfo(pos).protection or (isPlayer(pid) and getPlayerGroupId(pid) > 3) or (isBot(pid) and math.abs(getPlayerGUID(pid) - guid) < friendGUIDrange)) then
							table.remove(targets, i)
						elseif(not canGoTo(cid, tpos, 0, 1, 1, 1, 12)) then
							table.remove(targets, i)
							addIgnored(guid, pid, 2)
						else
							local dist = getDistanceBetween(pos, tpos)
							if dist < minDist then
								minDist = dist
								targetID = pid
								targetTableID = i
							end
						end
					end
				end
				if(targetID == 0) then
					break
				end
				if(setNewTarget(cid, guid, targetID)) then
					break
				else
					table.remove(targets, targetTableID)
				end
			end
		end
		if(getCreatureTarget(cid) > 0) then
			castBestAttackingSpell(cid, guid)
			if(checkInterval(guid, 20) and math.random(1, 2) == 1) then
				local specs = getSpectators(pos, 1, 1, false)
				for _, spec in pairs(specs) do
					if(isBot(spec)) then
						local friendGUID = getPlayerGUID(spec)
						if(math.abs(friendGUID - guid) < friendGUIDrange) then
							setNewTarget(spec, friendGUID, getCreatureTarget(cid))
						end
					end
				end
			end
		elseif(checkInterval(guid, 2) and not isWalking(cid)) then
			if(reachDestinationPoint(guid, pos)) then
				if(b_points[b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)+getCurrentRouteDirection(guid)]] ~= nil) then
					-- if it is possible to continue the route, go to the next point
					setCurrentRoutePoint(guid, getCurrentRoutePoint(guid)+getCurrentRouteDirection(guid))
					goTo(cid, b_points[b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)]], 0, 1, 1, 1, 12)
				else
					-- check if by the stairs
					local stairPosition = nil
					for i = 1, #b_stairs do
						if(getDistanceBetween(pos, b_stairs[i]) == 1) then
							stairPosition = b_stairs[i]
						end
					end
					if(not isExhaustChangeFloor(guid) and stairPosition ~= nil) then
						doMoveCreature(cid, getDirectionTo(pos, stairPosition))
						setExhaustChangeFloor(guid, 2000)
					elseif(chooseClosestRoute(pos, cid, guid) ~= 0) then
						--print("PT:" .. b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)])
						--print("RT:" .. getCurrentRoute(guid))
						goTo(cid, b_points[b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)]], 0, 1, 1, 1, 12)
					end
				end
			elseif(goTo(cid, b_points[b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)]], 0, 1, 1, 1, 12)) then
				-- it should go to the point it last went to
			elseif(chooseClosestRoute(pos, cid, guid) ~= 0) then
				-- if you found a reachable point and a new route, go there
				--print("PT:" .. b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)])
				--print("RT:" .. getCurrentRoute(guid))
				goTo(cid, b_points[b_routes[getCurrentRoute(guid)][getCurrentRoutePoint(guid)]], 0, 1, 1, 1, 12)
			elseif(not isExhaustChangeFloor(guid)) then
				-- failed, stands and waits in the gangway or goes up the stairs
				local stairPosition = nil
				for i = 1, #b_stairs do
					if(getDistanceBetween(pos, b_stairs[i]) == 1) then
						stairPosition = b_stairs[i]
					end
				end
				if(stairPosition ~= nil) then
					doMoveCreature(cid, getDirectionTo(pos, stairPosition))
				end
				setExhaustChangeFloor(guid, 2000)
			end
		end
	end
	return true
end