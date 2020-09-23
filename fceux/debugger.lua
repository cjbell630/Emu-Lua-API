---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@module debugger Contains functions for interacting with the debugger.
debugger = {}

--TODO: do

---Simulates a breakpoint hit, pauses emulation and brings up the Debugger window. Use this function in your handlers of custom breakpoints.
function debugger.hitbreakpoint() end

---Returns an integer value representing the number of CPU cycles elapsed since the poweron or since the last reset of the cycles counter.
---@return number
function debugger.getcyclescount() end

---Returns an integer value representing the number of CPU instructions executed since the poweron or since the last reset of the instructions counter.
---@return number
function debugger.getinstructionscount() end

---Resets the cycles counter.
function debugger.resetcyclescount() end

---Resets the instructions counter.
function debugger.resetinstructionscount() end

return debugger