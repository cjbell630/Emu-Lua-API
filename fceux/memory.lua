---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@alias CPURegister string | '"a"' | '"x"' | '"y"' | '"s"' | '"p"' | '"pc"'
---@module memory Contains functions for interacting with the memory.
memory = {}

---Get a single unsigned byte from the RAM at the given address.
--->
---Aliases:
--->    `memory.readbyteunsigned`
---@see memory.readbyteunsigned
---@param address number The address to read from RAM
---@return number A single unsigned byte from the RAM at the given address (*will always be positive*)
function memory.readbyte(address)
end

---Get a single unsigned byte from the RAM at the given address.
--->
---Aliases:
--->    `memory.readbyte`
---@see memory.readbyte
---@param address number The address to read from RAM
---@return number A single unsigned byte from the RAM at the given address (*will always be positive*)
function memory.readbyteunsigned(address)
end

---Get a specified length of bytes starting at the given address and return it as a string.
---
---Convert to table to access the individual bytes.
---@param address number The address to read from RAM
---@param length number The number of bytes to read from the initial address
---@return string The specified number of bytes at the specified address as a string
function memory.readbyterange(address, length)
end

---Get a single signed byte from the RAM at the given address.
---The most significant bit will serve as the sign.
---@param address number The address to read from RAM
---@return number A single signed byte from the RAM at the given address (*will always be positive*)
function memory.readbytesigned(address)
end

---Get an unsigned word (2 bytes, 16 bits) from the RAM at the given address.
---
---* If you only provide a single parameter (addressLow), the function treats it as the address of a little-endian word.
---
---* If you provide two parameters, the function reads the low byte from `addressLow` and the high byte from `addressHigh`,
---so you can use it in games which like to store their variables in separate form (a lot of NES games do).
--->
---Aliases:
--->    `memory.readwordunsigned`
---@see memory.readwordunsigned
---@overload fun(addressLow: number):number
---@param addressLow number If `addressLow` the only parameter, the address of a little-endian word | Otherwise, the address of the low byte
---@param addressHigh number _ **OPTIONAL** The address of the high byte
---@return number An unsigned 16-bit value from the RAM at the given address (*will always be positive*)
function memory.readword(addressLow, --[[optional]]addressHigh)
end

---Get an unsigned word (2 bytes, 16 bits) from the RAM at the given address.
---
---* If you only provide a single parameter (addressLow), the function treats it as the address of a little-endian word.
---
---* If you provide two parameters, the function reads the low byte from `addressLow` and the high byte from `addressHigh`,
---so you can use it in games which like to store their variables in separate form (a lot of NES games do).
--->
---Aliases:
--->    `memory.readword`
---@see memory.readword
---@overload fun(addressLow: number):number
---@param addressLow number If `addressLow` the only parameter, the address of a little-endian word | Otherwise, the address of the low byte
---@param addressHigh number _ **OPTIONAL** The address of the high byte
---@return number An unsigned 16-bit value from the RAM at the given address (*will always be positive*)
function memory.readwordunsigned(addressLow, --[[optional]]addressHigh)
end

---Get a signed word (2 bytes, 16 bits) from the RAM at the given address. It's most significant bit will server as the sign.
---
---* If you only provide a single parameter (addressLow), the function treats it as the address of a little-endian word.
---
---* If you provide two parameters, the function reads the low byte from `addressLow` and the high byte from `addressHigh`,
---so you can use it in games which like to store their variables in separate form (a lot of NES games do).
---@overload fun(addressLow: number):number
---@param addressLow number If `addressLow` the only parameter, the address of a little-endian word | Otherwise, the address of the low byte
---@param addressHigh number _ **OPTIONAL** The address of the high byte
---@return number A signed 16-bit value from the RAM at the given address
function memory.readwordsigned(addressLow, --[[optional]]addressHigh)
end

---Write the value to the RAM at the given address.
---
---**The value is modded with 256 before writing (so writing 257 will actually write 1).**
---
---Negative values allowed.
---@param address number The address of RAM to write to
---@param value number The value to write to the specified value of RAM
function memory.writebyte(address, value)
end

---Returns the current value of the given hardware register.
---For example, `memory.getregister("pc")` will return the main CPU's current Program Counter.
--->
---**Accepted values for `cpuregistername` are:**
--->    `CPURegister = {"a", "x", "y", "s", "p", "pc"}`
---@param cpuregistername CPURegister The name of the CPU register to get the value of (see above for accepted names)
---@return number The value of the specified CPU register
function memory.getregister(cpuregistername)
end

---Sets the current value of the given hardware register.
---For example, `memory.setregister("pc", 0x200)` will change the main CPU's current Program Counter to 0x200.
--->
---**Accepted values for `cpuregistername` are:**
--->    `CPURegister = {"a", "x", "y", "s", "p", "pc"}`
---
--->
---
---**IMPORTANT:**
---You had better know exactly what you're doing or you're probably just going to crash the game if you try to use this function.
---That applies to the other memory.write functions as well, but to a lesser extent.
---@param cpuregistername CPURegister The name of the CPU register to change (see above for accepted names)
---@param value number The value to set the specified CPU register to
function memory.setregister(cpuregistername, value)
end

---Registers a function to be called immediately whenever the given memory address range is written to.
---
---For example, if size is 100 and address is 0x0200, then you will register the function across all 100 bytes from 0x0200 to 0x0263, meaning a write to any of those bytes will trigger the function.
---
---Having callbacks on a large range of memory addresses can be expensive, so try to use the smallest range that's necessary for whatever it is you're trying to do.
--->
---The callback function will receive three arguments (`address`, `size`, `value`) indicating what write operation triggered the callback.
---Since 6502 writes are always single byte, the `size` argument will always be 1.
---You may use a `memory.write` function from inside the callback to change the value that just got written.
---However, keep in mind that doing so will trigger your callback again, so you must have a "base case" such as checking to make sure that the value is not already what you want it to be before writing it.
---Another, more drastic option is to de-register the current callback before performing the write.
--->
-----Aliases:
----->    `memory.registerwrite`
---@see memory.registerwrite
---@overload fun(address: number, func: function):void
---@param address number the address in CPU address space (0x0000 - 0xFFFF)
---@param size number _ **OPTIONAL** The number of bytes to "watch". ***default value:*** **1**
---@param func function if `nil`, de-register any memory write callbacks on the given range of bytes. Else, registers the given `function`
function memory.register(address, --[[optional]]size, func)
end

---Registers a function to be called immediately whenever the given memory address range is written to.
---
---For example, if size is 100 and address is 0x0200, then you will register the function across all 100 bytes from 0x0200 to 0x0263, meaning a write to any of those bytes will trigger the function.
---
---Having callbacks on a large range of memory addresses can be expensive, so try to use the smallest range that's necessary for whatever it is you're trying to do.
--->
---The callback function will receive three arguments (`address`, `size`, `value`) indicating what write operation triggered the callback.
---Since 6502 writes are always single byte, the `size` argument will always be 1.
---You may use a `memory.write` function from inside the callback to change the value that just got written.
---However, keep in mind that doing so will trigger your callback again, so you must have a "base case" such as checking to make sure that the value is not already what you want it to be before writing it.
---Another, more drastic option is to de-register the current callback before performing the write.
--->
---Aliases:
--->    `memory.register`
---@see memory.register
---@overload fun(address: number, func: function):void
---@param address number the address in CPU address space (0x0000 - 0xFFFF)
---@param size number _ **OPTIONAL** The number of bytes to "watch". ***default value:*** **1**
---@param func function if `nil`, de-register any memory write callbacks on the given range of bytes. Else, registers the given `function`
function memory.registerwrite(address, --[[optional]]size, func)
end

--TODO: it says value will always be 0 and size will always be 1. Verify this and see if you can explain that simpler here.
---Registers a function to be called immediately whenever the emulated system runs code located in the given memory address range.
---Since "address" is the address in CPU address space (0x0000 - 0xFFFF), this doesn't take ROM banking into account, so the callback will be called for any bank, and in some cases you'll have to check current bank in your callback function.
---For example, if size is 100 and address is 0x0200, then you will register the function across all 100 bytes from 0x0200 to 0x0263, meaning an execution of any of those bytes will trigger the function.
---
---Having callbacks on a large range of memory addresses can be expensive, so try to use the smallest range that's necessary for whatever it is you're trying to do.
--->
---The callback function will receive three arguments (`address`, `size`, `value`) indicating what write operation triggered the callback.
---Since 6502 writes are always single byte, the `size` argument will always be 1. Additionally, `value` will always be 0.
--->
---Aliases:
--->    `memory.registerrun`
---
--->    `memory.registerexecute`
---@see memory.registerrun
---@see memory.registerexecute
---@overload fun(address: number, func: function):void
---@param address number the address in CPU address space (0x0000 - 0xFFFF)
---@param size number _ **OPTIONAL** The number of bytes to "watch". ***default value:*** **1**
---@param func function if `nil`, de-register any memory write callbacks on the given range of bytes. Else, registers the given `function`
function memory.registerexec(address, --[[optional]]size, func)
end

--TODO: it says value will always be 0 and size will always be 1. Verify this and see if you can explain that simpler here.
---Registers a function to be called immediately whenever the emulated system runs code located in the given memory address range.
---Since "address" is the address in CPU address space (0x0000 - 0xFFFF), this doesn't take ROM banking into account, so the callback will be called for any bank, and in some cases you'll have to check current bank in your callback function.
---For example, if size is 100 and address is 0x0200, then you will register the function across all 100 bytes from 0x0200 to 0x0263, meaning an execution of any of those bytes will trigger the function.
---
---Having callbacks on a large range of memory addresses can be expensive, so try to use the smallest range that's necessary for whatever it is you're trying to do.
--->
---The callback function will receive three arguments (`address`, `size`, `value`) indicating what write operation triggered the callback.
---Since 6502 writes are always single byte, the `size` argument will always be 1. Additionally, `value` will always be 0.
--->
---Aliases:
--->    `memory.registerexec`
---
--->    `memory.registerexecute`
---@see memory.registerexec
---@see memory.registerexecute
---@overload fun(address: number, func: function):void
---@param address number the address in CPU address space (0x0000 - 0xFFFF)
---@param size number _ **OPTIONAL** The number of bytes to "watch". ***default value:*** **1**
---@param func function if `nil`, de-register any memory write callbacks on the given range of bytes. Else, registers the given `function`
function memory.registerrun(address, --[[optional]]size, func)
end

--TODO: it says value will always be 0 and size will always be 1. Verify this and see if you can explain that simpler here.
---Registers a function to be called immediately whenever the emulated system runs code located in the given memory address range.
---Since "address" is the address in CPU address space (0x0000 - 0xFFFF), this doesn't take ROM banking into account, so the callback will be called for any bank, and in some cases you'll have to check current bank in your callback function.
---For example, if size is 100 and address is 0x0200, then you will register the function across all 100 bytes from 0x0200 to 0x0263, meaning an execution of any of those bytes will trigger the function.
---
---Having callbacks on a large range of memory addresses can be expensive, so try to use the smallest range that's necessary for whatever it is you're trying to do.
--->
---The callback function will receive three arguments (`address`, `size`, `value`) indicating what write operation triggered the callback.
---Since 6502 writes are always single byte, the `size` argument will always be 1. Additionally, `value` will always be 0.
--->
---Aliases:
--->    `memory.registerexec`
---
--->    `memory.registerrun`
---@see memory.registerexec
---@see memory.registerrun
---@overload fun(address: number, func: function):void
---@param address number the address in CPU address space (0x0000 - 0xFFFF)
---@param size number _ **OPTIONAL** The number of bytes to "watch". ***default value:*** **1**
---@param func function if `nil`, de-register any memory write callbacks on the given range of bytes. Else, registers the given `function`
function memory.registerexecute(address, --[[optional]]size, func)
end

return memory