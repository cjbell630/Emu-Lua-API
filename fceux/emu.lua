---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@module emu contains functions for interacting with the emulator.
emu = {}

---Executes a power cycle.
function emu.poweron()
end

---Executes a (soft) reset.
function emu.softreset()
end

--TODO: wtf does that thing about turbo mean, since turbo is also one of the choices???
---Set the emulator to given speed.
--->
---**Accepted values for `mode` are:**
--->    `SpeedMode = {"normal", "nothrottle", "turbo", "maximum"}`
---
---`"nothrottle"` is the same as turbo on fceux.
---@alias SpeedMode string | '"normal"' | '"nothrottle"' | '"turbo"' | '"maximum"'
---@param mode SpeedMode the speed mode to set the emulator to (see above for accepted modes)
function emu.speedmode(mode)
end

--TODO: What register methods???
---Advance the emulator by one frame.
---It's like pressing the frame advance button once.
--->
---Most scripts use this function in their main game loop to advance frames.
---Note that you can also register functions by various methods that run "dead", returning control to the emulator and letting the emulator advance the frame.
---For most people, using frame advance in an endless while loop is easier to comprehend so I suggest  starting with that.
---This makes more sense when creating bots. Once you move to creating auxillary libraries, try the `register()` methods.
function emu.frameadvance()
end

---Pauses the emulator.
function emu.pause()
end

--TODO: wtf does it return???
---Calls given function, restricting its working time to given number of lua cycles.
---Using this method you can ensure that some heavy operation (like Lua bot) won't freeze FCEUX.
---@param count number The number of lua cycles to restrict the function's working time to
---@param func function The function to restrict the working time of
---@return number Some number - possibly the number of cycles it took?
function emu.exec_count(count, func)
end

--TODO: BUGGED!!!!
---**Windows-only.** Calls given function, restricting its working time to given number of milliseconds (approximate).
---Using this method you can ensure that some heavy operation (like Lua bot) won't freeze FCEUX.
--->
---**IMPORTANT** - This is probably bugged. Let me know if you get this to work.
---@param time number The time in milliseconds to restrict the function's working time to
---@param func function The function to restrict the working time of
---@return number probably a number, based on the return value of [emu.exec_count]. But I don't know for sure.
function emu.exec_time(time, func)
end

--TODO: is there any way to only change one?
---Toggles the drawing of the sprites and background planes.
---Set to false or nil to disable a pane, anything else will draw them.
---@param sprites boolean true to enable drawing of sprites, false or nil to disable
---@param background boolean true to enable drawing of the background, false or nil to disable
function emu.setrenderplanes(sprites, background)
end

---Displays given message on screen in the standard messages position.
---Use [gui.text()][gui.lua] when you need to position text.
---@param message string The text to display
function emu.message(message)
end

--TODO: be more specific
---Returns the framecount value.
---The frame counter runs without a movie running so this always returns a value.
---@return number The framecount value
function emu.framecount()
end

---Returns the number of lag frames encountered (same as the number indicated on the lag counter).
---Lag frames are frames where the game did not poll for input because it missed the vblank.
---This happens when it has to compute too much within the frame boundary.
---@return number The number of lag frames encountered
function emu.lagcount()
end

---Returns whether or not the game is currently in a lag frame.
---@return boolean true if currently in a lag frame, false otherwise
function emu.lagged()
end

---Sets current value of lag flag.
--->
---Note: Some games poll input even in lag frames, so standard way of detecting lag (used by FCEUX and other emulators) does not work for those games, and you have to determine lag frames manually.
---First, find RAM addresses that help you distinguish between lag and non-lag frames (e.g. an in-game frame counter that only increments in non-lag frames).
---Then register memory hooks that will change lag flag when needed.
---@param value boolean The value to set the lag flag to
function emu.setlagflag(value)
end

---Returns whether or not the emulation has started.
---Certain operations such as using savestates are invalid to attempt before emulation has started.
---You probably won't need to use this function unless you want to make your script extra-robust to being started too early.
---@return boolean true if emulation has started, false otherwise
function emu.emulating()
end

---Returns whether or not the emulator is paused.
---@return boolean true if emulator is paused, false otherwise
function emu.paused()
end


--TODO: verify movie.readonly thing
---Returns whether the emulator is in read-only state.
---
---While this variable only applies to movies, it is stored as a global variable and can be modified even without a movie loaded.
---Hence, it is in the emu library rather than the movie library.
--->
---Aliases:
--->    `movie.readonly`
---@see movie.readonly
---@return boolean true if the emulator is in a read-only state, false if not
function emu.readonly()
end

--TODO: verify movie.setreadonly thing
---Sets the read-only status to read-only if argument is true and read+write if false.
---
---Note: This might result in an error if the medium of the movie file is not writeable (such as in an archive file).
---
---While this variable only applies to movies, it is stored as a global variable and can be modified even without a movie loaded.
---Hence, it is in the emu library rather than the movie library.
--->
---Aliases:
--->    `movie.setreadonly`
---@see movie.setreadonly
---@param state boolean The state to set the read-only status to (true: read-only | false: read+write)
function emu.setreadonly(state)
end

---Returns the path of fceux.exe.
---@return string the path of fceux.exe
function emu.getdir()
end

--TODO: use this
---Loads the ROM from the given directory relative to the lua script, or from the absolute path.
---If the ROM can't be loaded, loads the most recent one.
---@param filename string the absolute or relative (to the path of the lua script) path of the rom to load
function emu.loadrom(filename)
end

--TODO: bruhhh I do NOT feel like formatting this rn.
---Registers a callback function to run immediately before each frame gets emulated.
---This runs after the next frame's input is known but before it's used, so this is your only chance to set the next frame's input using the next frame's would-be input.
---For example, if you want to make a script that filters or modifies ongoing user input, such as making the game think "left" is pressed whenever you press "right", you can do it easily with this.
---Note that this is not quite the same as code that's placed before a call to emu.frameadvance.
---This callback runs a little later than that.
---Also, you cannot safely assume that this will only be called once per frame.
---Depending on the emulator's options, every frame may be simulated multiple times and your callback will be called once per simulation.
---If for some reason you need to use this callback to keep track of a stateful linear progression of things across frames then you may need to key your calculations to the results of emu.framecount.
---Like other callback-registering functions provided by FCEUX, there is only one registered callback at a time per registering function per script.
---If you register two callbacks, the second one will replace the first, and the call to emu.registerbefore will return the old callback.
---You may register nil instead of a function to clear a previously-registered callback.
---If a script returns while it still has registered callbacks, FCEUX will keep it alive to call those callbacks when appropriate, until either the script is stopped by the user or all of the callbacks are de-registered.
---@param func function The function to register
function emu.registerbefore(func)
end

--TODO: once you've formatted emu.registerbefore, find a way to put all that info here cleanly
---Registers a callback function to run immediately after each frame gets emulated.
---It runs at a similar time as (and slightly before) gui.register callbacks, except unlike with gui.register it doesn't also get called again whenever the screen gets redrawn.
---Similar caveats as those mentioned in emu.registerbefore apply.
---@param func function The function to register
function emu.registerafter(func)
end

--TODO: WHY DID HE WRITE SO MUCH
---Registers a callback function that runs when the script stops.
---Whether the script stops on its own or the user tells it to stop, or even if the script crashes or the user tries to close the emulator, FCEUX will try to run whatever Lua code you put in here first.
---So if you want to make sure some code runs that cleans up some external resources or saves your progress to a file or just says some last words, you could put it here.
---(Of course, a forceful termination of the application or a crash from inside the registered exit function will still prevent the code from running.)
---Suppose you write a script that registers an exit function and then enters an infinite loop.
---If the user clicks "Stop" your script will be forcefully stopped, but then it will start running its exit function.
---If your exit function enters an infinite loop too, then the user will have to click "Stop" a second time to really stop your script.
---That would be annoying. So try to avoid doing too much inside the exit function.
---Note that restarting a script counts as stopping it and then starting it again, so doing so (either by clicking "Restart" or by editing the script while it is running) will trigger the callback.
---Note also that returning from a script generally does NOT count as stopping
---(because your script is still running or waiting to run its callback functions and thus does not stop...see here for more information),
---even if the exit callback is the only one you have registered.
---@param func function The function to register
function emu.registerexit(func)
end

--TODO: is usage really necessary her of all places? either do it nowhere or everywhere I think.
--TODO: also format the return section
---Adds a Game Genie code to the Cheats menu.
---Usage: emu.addgamegenie("NUTANT")
---Note that the Cheats Dialog Box won't show the code unless you close and reopen it.
---@param str string the Game Genie code to add.
---@return boolean Returns false and an error message if the code can't be decoded. Returns false if the code couldn't be added. Returns true if the code already existed, or if it was added.
function emu.addgamegenie(str)
end

--TODO: do everythig from here down
---delgamegenie: Removes a Game Genie code from the Cheats menu. Returns false and an error message if the code can't be decoded. Returns false if the code couldn't be deleted. Returns true if the code didn't exist, or if it was deleted.
---Usage: emu.delgamegenie("NUTANT")
---Note that the Cheats Dialog Box won't show the code unless you close and reopen it.
---@param str string
---@return boolean
function emu.delgamegenie(str)
end

---print: Puts a message into the Output Console area of the Lua Script control window. Useful for displaying usage instructions to the user when a script gets run.
---@param str string
function emu.print(str)
end

---getscreenpixel: Returns the separate RGB components of the given screen pixel, and the palette. Can be 0-255 by 0-239, but NTSC only displays 0-255 x 8-231 of it. If getemuscreen is false, this gets background colors from either the screen pixel or the LUA pixels set, but LUA data may not match the information used to put the data to the screen. If getemuscreen is true, this gets background colors from anything behind an LUA screen element.
---Usage is local r,g,b,palette = emu.getscreenpixel(5, 5, false) to retrieve the current red/green/blue colors and palette value of the pixel at 5x5.
---Palette value can be 0-63, or 254 if there was an error.
---You can avoid getting LUA data by putting the data into a function, and feeding the function name to emu.registerbefore.
---@param x number
---@param y number
---@param getemuscreen boolean
---@return number
function emu.getscreenpixel(x, y, getemuscreen)
end
return emu