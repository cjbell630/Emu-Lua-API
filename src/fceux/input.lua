---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@module input Contains functions for interacting with keyboard and mouse input.
input = {}

--TODO
---Reads input from keyboard and mouse.
---Returns pressed keys and the position of mouse in pixels on game screen.
---The function returns a table with at least two properties; table.xmouse and table.ymouse.
---Additionally any of these keys will be set to true if they were held at the time of executing this function:
---leftclick, rightclick, middleclick, capslock, numlock, scrolllock,
---0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
---A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
---F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24,
---backspace, tab, enter, shift, control, alt, pause, escape, space, pageup, pagedown, end, home,
---left, up, right, down,
---numpad0, numpad1, numpad2, numpad3, numpad4, numpad5, numpad6, numpad7, numpad8, numpad9, numpad*,
---insert, delete, numpad+, numpad-, numpad., numpad/, semicolon, plus, minus,
---comma, period, slash, backslash, tilde, quote, leftbracket, rightbracket.
---@return table<string, number | boolean>
function input.get()
end
function input.read()
end

--TODO: doc
---OG DOC:
---Requests input from the user using a multiple-option message box. See gui.popup for complete usage and returns.
---@alias BoolString string | '"yes"' | '"no"'
---@param boxText string The string to display to the user in the box
---@return BoolString The text in the box selected by the user ("yes" or "no")
function input.popup(boxText)
end

--TODO: doc
---Opens a file select box for the user to choose a file with.
---Returns the path(s) of the chosen file(s).
---@return table<string> A table containing the path(s) to the file(s) selected by the user
function input.openfilepopup()
end

--TODO: doc
---Opens a file select box for the user to choose a file with.
---Returns the path(s) of the chosen file(s).
---Exactly the same as {@link input.openfilepopup} except it says "Save" instead of "Open".
---@return table<string> A table containing the path(s) to the file(s) selected by the user
function input.savefilepopup()
end