---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@alias SavestateObject userdata
---@module savestate Contains functions for interacting with the savestate interface of FCEUX.
savestate = {}

--TODO: detail that alias up there

--TODO: document (this is og)
---Create a new savestate object.
---Optionally you can save the current state to one of the predefined slots(1-10) using the range 1-9 for slots 1-9,
---and 10 for 0, QWERTY style.
---Using no number will create an "anonymous" savestate.
---Note that this does not actually save the current state!
---You need to create this value and pass it on to the load and save functions in order to save it.
---Anonymous savestates are temporary, memory only states.
---You can make them persistent by calling memory.persistent(state).
---Persistent anonymous states are deleted from disk once the script exits.
---@param slot number OPTIONAL - the slot number to use for this savestate. Uses an anonymous slot if nil.
---@return SavestateObject savestate object
function savestate.object(slot)
end

--TODO: document (this is og)
---savestate.create is identical to savestate.object,
---except for the numbering for predefined slots(1-10, 1 refers to slot 0, 2-10 refer to 1-9).
---It's being left in for compatibility with older scripts,
---and potentially for platforms with different internal predefined slot numbering.
---@param slot number OPTIONAL - the slot number to use for this savestate. Uses an anonymous slot if nil.
---@return SavestateObject savestate object
function savestate.create(slot)
end

--TODO: document (this is og)
---Save the current state object to the given savestate.
---The argument is the result of savestate.create().
---You can load this state back up by calling savestate.load(savestate) on the same object.
---@param savestateObj SavestateObject The savestate object to save
function savestate.save(savestateObj)
end

--TODO: document (this is og)
---Load the the given state.
---The argument is the result of savestate.create() and has been passed to savestate.save() at least once.
---If this savestate is not persistent and not one of the predefined states, the state will be deleted after loading.
---@param savestateObj SavestateObject The savestate object to load
function savestate.load(savestateObj)
end

--TODO: document (this is og)
---Set the given savestate to be persistent.
---It will not be deleted when you load this state,
---but at the exit of this script instead, unless it's one of the predefined states.
---If it is one of the predefined savestates it will be saved as a file on disk.
---@param savestateObj SavestateObject The savestate object to make persistent
function savestate.persist(savestateObj)
end

--TODO: document (this is og)
---Registers a callback function that runs whenever the user saves a state.
---This won't actually be called when the script itself makes a savestate,
---so none of those endless loops due to a misplaced savestate.save.
---As with other callback-registering functions provided by FCEUX,
---there is only one registered callback at a time per registering function per script.
---Upon registering a second callback, the first is kicked out to make room for the second.
---In this case, it will return the first function instead of nil, letting you know what was kicked out.
---Registering nil will clear the previously-registered callback.
---@param func function The function to run on savestate save
function savestate.registersave(func)
end

--TODO: document (this is og)
---Registers a callback function that runs whenever the user loads a previously saved state.
---It's not called when the script itself loads a previous state,
---so don't worry about your script interrupting itself just because it's loading something.
---The state's data is loaded before this function runs,
---so you can read the RAM immediately after the user loads a state, or check the new framecount.
---Particularly useful if you want to update lua's display right away instead of showing junk from before the loadstate.
---@param func function The function to run on savestate load
function savestate.registerload(func)
end

--TODO: document (this is og)
---Accuracy not yet confirmed.
---Intended Function, according to snes9x LUA documentation:
---Returns the data associated with the given savestate (data that was earlier returned by a registered save callback)
---without actually loading the rest of that savestate or calling any callbacks.
---location should be a save slot number.
---@param location number what
function savestate.loadscriptdata(location)
end