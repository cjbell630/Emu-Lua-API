---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@alias bit number | 0 | 1
---@module zapper Contains functions for interacting with the Zapper.
zapper = {}

--TODO
---Returns the zapper data.
---When no movie is loaded this input is the same as the internal mouse input
---(which is used to generate zapper input, as well as the arkanoid paddle).
---When a movie is playing, it returns the zapper data in the movie code.
---The return table consists of 3 values: x, y, and fire.
---x and y are the x,y coordinates of the zapper target in terms of pixels.
---fire represents the zapper firing.  0 = not firing, 1 = firing
---Note: The zapper is always controller 2 on the NES so there is no player argument to this function.
---@return table<number, number, bit>
function zapper.read()
end