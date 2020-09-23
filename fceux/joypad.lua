---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@alias ButtonName string | '"A"' | '"up"' | '"left"' | '"B"' | '"select"' | '"right"' | '"down"' | '"start"'
---@alias ButtonState boolean|string
---@module joypad Contains functions for interacting with the joypad.
joypad = {}
--TODO: figure out wtf to do for the tables
--it's not a string, it's not idek anymore
--TODO: do

---Returns a table of every game button, where each entry is true if that button is currently held (as of the last time the emulation checked), or false if it is not held. This takes keyboard inputs, not Lua. The table keys look like this (case sensitive):
---up, down, left, right, A, B, start, select
---Where a Lua truthvalue true means that the button is set, false means the button is unset. Note that only "false" and "nil" are considered a false value by Lua.  Anything else is true, even the number 0.
---joypad.read left in for backwards compatibility with older versions of FCEU/FCEUX.
---@param player number The player number to get the input of
---@return table<ButtonName, ButtonState>
function joypad.get(player) end
function joypad.read(player) end

---Returns a table of every game button, where each entry is true if that button is held at the moment of calling the function, or false if it is not held. This function polls keyboard input immediately, allowing Lua to interact with user even when emulator is paused.
---As of FCEUX 2.2.0, the function only works in Windows. In Linux this function will return nil.
---@param player number The player number to get the input of
function joypad.getimmediate(player) end
function joypad.readimmediate(player) end

---Returns a table of only the game buttons that are currently held. Each entry is true if that button is currently held (as of the last time the emulation checked), or nil if it is not held.
---@param player number The player number to get the input of
function joypad.getdown(player) end
function joypad.readdown(player) end

---Returns a table of only the game buttons that are not currently held. Each entry is nil if that button is currently held (as of the last time the emulation checked), or false if it is not held.
---@param player number The player number to get the input of
function joypad.getup(player) end
function joypad.readup(player) end

---Set the inputs for the given player. Table keys look like this (case sensitive):
---up, down, left, right, A, B, start, select
---There are 4 possible values: true, false, nil, and "invert".
---true    - Forces the button on
---false   - Forces the button off
---nil     - User's button press goes through unchanged
---"invert"- Reverses the user's button press
---Any string works in place of "invert".  It is suggested as a convention to use "invert" for readability, but strings like "inv", "Weird switchy mechanism", "", or "true or false" works as well as "invert".
---nil and "invert" exists so the script can control individual buttons of the controller without entirely blocking the user from having any control. Perhaps there is a process which can be automated by the script, like an optimal firing pattern, but the user still needs some manual control, such as moving the character around.
---joypad.write left in for backwards compatibility with older versions of FCEU/FCEUX.
---@param player number The player number to set the input of
---@param input table<ButtonName, ButtonState> The table to set the input to
function joypad.set(player, input) end
function joypad.write(player, input) end

return joypad