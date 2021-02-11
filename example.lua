funcs = {
    --["emu.exec_time"] = {emu.exec_time(1000, print)}, --BUGGED
    --["rom.getfilename"] = {rom.getfilename()} --REMOVED
    ["savestate.object"] = { savestate.object(1) },
    ["savestate.create"] = { savestate.create(1) },
    --["savestate.save"] = { savestate.save() },
    --["savestate.load"] = { savestate.load() },
    --["savestate.persist"] = { savestate.persist() },
    ["savestate.registersave"] = { savestate.registersave() },
    ["savestate.registerload"] = { savestate.registerload() },
    --["savestate.loadscriptdata"] = { savestate.loadscriptdata() } might be savestate obj instead
    --[[
registerload
loadscriptdata
object
registersave
load
save
create
persist
]]--
}

--[[funcs = {
    ["emu.exec_count"] = { emu.exec_count(1000, print("")) },
    ["emu.loadrom"] = { emu.loadrom("romname") },
    ["emu.lagged"] = { emu.lagged() },
    ["emu.readonly"] = { emu.readonly() },
    ["emu.lagcount"] = { emu.lagcount() },
    ["emu.print"] = { emu.print("string") },
    ["emu.getscreenpixel"] = { emu.getscreenpixel(15, 15, true) },
    ["emu.message"] = { emu.message("string") },
    ["emu.getdir"] = { emu.getdir() },
    ["emu.setlagflag"] = { emu.setlagflag(true) },
    ["emu.setrenderplanes"] = { emu.setrenderplanes(true, true) },
    ["emu.setreadonly"] = { emu.setreadonly(true) },
    ["emu.emulating"] = { emu.emulating() },
    ["emu.addgamegenie"] = { emu.addgamegenie("string") },
    ["emu.frameadvance"] = { emu.frameadvance() },
    ["emu.poweron"] = { emu.poweron() },
    ["emu.pause"] = { emu.pause() },
    ["emu.registerexit"] = { emu.registerexit(print) },
    ["emu.unpause"] = { emu.unpause() },
    ["emu.registerafter"] = { emu.registerafter(print) },
    ["emu.registerbefore"] = { emu.registerbefore(print) },
    ["emu.softreset"] = { emu.softreset() },
    ["emu.paused"] = { emu.paused() },
    ["emu.framecount"] = { emu.framecount() },
    ["emu.speedmode"] = { emu.speedmode("normal") },
    ["emu.delgamegenie"] = { emu.delgamegenie("string") },

    ["rom.readbyteunsigned"] = { rom.readbyteunsigned(0xF0F) },
    ["rom.readbytesigned"] = { rom.readbytesigned(0xF0F) },
    ["rom.writebyte"] = { rom.writebyte(0xF0F, 0xD) },
    ["rom.readbyte"] = { rom.readbyte(0xF0F) },
    ["rom.gethash"] = { rom.gethash("md5") },

    ["memory.writebyte"] = { memory.writebyte(0xF0F, 15) },
    ["memory.registerexec"] = { memory.registerexec(0xF0F, print) },
    ["memory.registerexec 3 params"] = { memory.registerexec(0xF0F, 9, print) },
    ["memory.readbyte"] = { memory.readbyte(0xF0F) },
    ["memory.registerrun"] = { memory.registerrun(0xF0F, print) },
    ["memory.registerrun 3 params"] = { memory.registerrun(0xF0F, 9, print) },
    ["memory.readword"] = { memory.readword(0xF0F) },
    ["memory.readword 2 params"] = { memory.readword(0xF0F, 0xFFF) },
    ["memory.getregister"] = { memory.getregister("pc") },
    ["memory.register"] = { memory.register(0xF0F, print) },
    ["memory.register 3 params"] = { memory.register(0xF0F, 9, print) },
    ["memory.registerexecute"] = { memory.registerexecute(0xF0F, print) },
    ["memory.registerexecute 3 params"] = { memory.registerexecute(0xF0F, 9, print) },
    ["memory.readbyterange"] = { memory.readbyterange(0xF0F, 4) },
    ["memory.readwordsigned"] = { memory.readwordsigned(0xF0F) },
    ["memory.readwordsigned 2 params"] = { memory.readwordsigned(0xF0F, 0xFFF) },
    ["memory.registerwrite"] = { memory.registerwrite(0xF0F, print) },
    ["memory.registerwrite 3 params"] = { memory.registerwrite(0xF0F, 9, print) },
    ["memory.readwordunsigned"] = { memory.readwordunsigned(0xF0F) },
    ["memory.readwordunsigned 2 params"] = { memory.readwordunsigned(0xF0F, 0xFFF) },
    ["memory.readbytesigned"] = { memory.readbytesigned(0xF0F) },
    ["memory.readbyteuunsigned"] = { memory.readbyteunsigned(0xF0F) },
    ["memory.setregister"] = { memory.setregister("pc", 0x200) },

    ["debugger.getcyclescount"] = { debugger.getcyclescount() },
    ["debugger.getinstructionscount"] = { debugger.getinstructionscount() },
    ["debugger.hitbreakpoint"] = { debugger.hitbreakpoint() },
    ["debugger.resetcyclescount"] = { debugger.resetcyclescount() },
    ["debugger.resetinstructionscount"] = { debugger.resetinstructionscount() }
}]]

for k, v in pairs(savestate) do
    print(k.." "..tostring(v).."\n")
end
file = io.open("D:\\cb106\\Documents\\GitHub\\Emu-Lua-API\\output.html", "w+")
file:write("<html><head><style>table {border-collapse: collapse;width: 100%;border: 1px solid black;}th, td {text-align: left;padding: 8px;border: 1px solid black;}tr:nth-child(even) {background-color: #d0d0d0;border: 1px solid black;}</style></head><body><table style=\"width:100%\">")
file:close()
file = io.open("D:\\cb106\\Documents\\GitHub\\FCEUX-Lua-API\\output.html", "a")
for name, result in pairs(funcs) do
    file:write("<tr><td>")
    file:write(name)
    file:write("</td>")
    no_return_value = true
    for _, i in pairs(result) do
        file:write("<td>")
        file:write((i == nil) and "this shouldn't be here" or type(i) .. ": " .. tostring(i))
        file:write("</td>")
        no_return_value = false
    end
    file:write(no_return_value and "<td><p style=\"color:TOMATO;\">no return value</p></td></tr>" or "</tr>")
end
file:write("</table></body></html>")
file:close()

for k, v in pairs(joypad.get(1)) do
    print(tostring(k) .. ": " .. tostring(type(k)) .. "\n")
    print(tostring(v) .. ": " .. tostring(type(v)) .. "\n\n")
end
joypad.get()
savestate.object()

emu.frameadvance()
print("done")

