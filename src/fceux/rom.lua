---Original API created by the creators of FCEUX.
---Some documentation for this document taken from http://fceux.com/web/help/fceux.html?LuaFunctionsList.html
---This document created by Connor Bell.
---@author Connor Bell
---@module rom Contains functions for interacting with the ROM
rom = {}

---Get the base filename of the ROM loaded.
---@deprecated # **REMOVED!**
---(as of fceux v2.2.3)
function rom.getfilename()
end

---Get a hash of the ROM loaded, for verification.
--->
---If type is "md5", returns a hex string of the MD5 hash.
---If type is "base64", returns a base64 string of the MD5 hash, just like the movie romChecksum value.
--->
---**Accepted values for `type` are:**
--->    `HashType = {"md5", "base64"}`
---@alias HashType string | '"md5"' | '"base64"'
---@param type HashType The type of string to return the hash as (see above for accepted names)
---@return string the hash rendered in the specified string type
function rom.gethash(type)
end

--TODO: doesn't seem to have individual documentation
---readbyte:
---@param address number
---@return number the number at that address
function rom.readbyte(address)
end

---Get an unsigned byte from the actual ROM file at the given address.
---This includes the header! It's the same as opening the file in a hex-editor.
---
---@param address number The address to read from the ROM
---@return number The unsigned value at the specified ROM address
function rom.readbyteunsigned(address)
end

---Get a signed byte from the actual ROM file at the given address. Returns a byte that is signed.
---This includes the header! It's the same as opening the file in a hex-editor.
---@param address number The address to read from the ROM
---@return number The signed value at the specified ROM address
function rom.readbytesigned(address)
end

--TODO: verify return
---Write the value to the ROM at the given address.
---`value` is reduced to a range of 256 before writing (`value` modulo 256).
---Negative values allowed.
---Editing the header is not available.
---@param address number The address to write to
---@param value number The value to write to that address
---@return number The value that was written
function rom.writebyte(address, value)
end
return rom