#!/usr/bin/lua
--https://stackoverflow.com/a/45723121/12861567
--------------------------------------------------------------------
--|Functs.lua load available modules parse tables give write to HTML|
--|Table Of Contents, modules, available functions, strings etc..   |
--------------------------------------------------------------------
-- CONFIGURE----------------------------------------------------------------------------------------
local sPkgPath = "/usr/lib/lua" --look here for modules to load in addition to the intrinsic ones
local sWpkgPath = "C:\\Program Files (x86)\\Lua\\5.1\\lua\\" --package path for windows
local sURLsearch = "http://pgl.yoyo.org/luai/i/" --for lua standard functions search this site
local iMaxStr = 1024 -- maximum characters in a string printed to HTML table
local sFileOut = "functs.html"
----------------------------------------------------------------------------------------------------
local tQuery = {} --key,val pairs of arguments
local sQuery = "" --string of arguments ex:'?modload=no&module=_G.math...'
local sResults = "" --Results of each step through
local sEnv = "web" --running on a web server?
----------------------------------------------------------------------------------------------------
local modsBlacklist = {
    "coroutine",
    "package",
    "utf8",
    "arg",
    "debug",
    "string",
    "bit32",
    "math",
    "table",
    "io",
    "os"
}

local funcsBlacklist = {
    "assert",
    "collectgarbage",
    "dofile",
    "error",
    "getmetatable",
    "ipairs",
    "load",
    "loadfile",
    "next",
    "pairs",
    "pcall",
    "print",
    "rawequal",
    "rawget",
    "rawlen",
    "rawset",
    "require",
    "select",
    "setemetatable",
    "tonumber",
    "tostring",
    "type",
    "xpcall"
}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

----------------------------FUNCTIONS START----------------------------------------------
local function a2m_m2a(addr_member)
    --turns members into addresses; addresses back into members
    return addr_member
end

local function PrRes(sVal)
    --cats results strings
    sResults = sResults .. sVal
end

local function errorHandler(err)
    PrRes(" ERROR:" .. err .. " ")
    --print(debug.traceback())
end

local function putOutput(tData, iCt)
    --keys are integer indices, values to iCt written, if iCt = nil whole table written
    for k, v in ipairs(tData) do
        if iCt == nil or k <= iCt then
            io.write(v) --write to std out could be changed here, or as below we change stdout file
        end
    end
end

local function parse_url(s)
    --http://www.flashair-developers.com/en/support/forum/#/discussion/880/getting-query-string-parameters-from-an-http-request-in-lua/
    --splits on '=' and '&' puts argument string into named keys with value [Key1] = (val1)&[Key2] = (val2)
    --ex: Key1=va1&Key2=val2
    local ans = { [0] = "" }

    ----FUNCTIONS for parse_url -----------------------------------------------------
    local function decode(s)
        s = s:gsub('+', ' ')
        s = s:gsub('%%(%x%x)', function(h)
            return string.char(tonumber(h, 16))
        end)
        return s
    end
    ----END FUNCTIONS for parse_url --------------------------------------------------

    if s == nil then
        return ans
    end
    --s = s:match('%s+(.+)')

    for k, v in s:gmatch('([^&=]+)=([^&=]*)&?') do
        --2 capture groups all chars (not '&' or '=') '=' all chars (not '&' or '=') followed by '' or '&' or '?'
        ans[k] = decode(v)
    end
    return ans
end

local function tableByName(tName)
    --find the longest match possible to an actual table
    --Name comes in as (table) tName.var so we can pass back out the name found PITA
    --returns the table found (key and value)
    local ld = {}
    local sMatch = ""
    local kMatch = nil
    local vMatch = nil

    ----FUNCTIONS for tableByName -----------------------------------------------------
    local function search4Str(n, k, v)
        local sKey = tostring(k)
        if string.find(n, sKey, 1, true) then
            if sKey:len() > sMatch:len() then
                sMatch = sKey
                kMatch = k
                vMatch = v
            end
            --find the longest match we can
        end
    end
    ----END FUNCTIONS for tableByName -------------------------------------------------

    if tName.val ~= nil and tName.val ~= "" then
        for k, v in pairs(_G) do
            --_G check both since some tables are only in _G or package.loaded
            search4Str(tName.val, k, v)
        end
        for k, v in pairs(package.loaded) do
            --package.loaded
            search4Str(tName.val, k, v)
        end
        if not string.find(sMatch, "_G", 1, true) then
            sMatch = "_G." .. sMatch
        end -- put the root _G in if not exist
        if kMatch and vMatch then
            ld[kMatch] = vMatch
            tName.val = sMatch
            return ld
        end
    end
    tName.val = "_G"
    return package.loaded --Not Found return default
end

local function get_common_branches(t, tRet)
    --load t 'names(values)' into keys
    --strip off long paths then iterate value if it exists
    --local tRet={}
    local sBranch = ""
    local tName
    for k in pairs(t) do
        tName = { ["val"] = k }
        tableByName(tName)
        sBranch = tName.val
        if tRet[sBranch] == nil then
            tRet[sBranch] = 1 --first instance of this branch
        else
            tRet[sBranch] = tRet[sBranch] + 1
        end
    end
end

local function pairsByPairs (t, tkSorted)
    --tkSorted should be an already sorted (i)table with t[keys] in the values
    --https://www.lua.org/pil/19.3.html
    --!!Note: table sort default function does not like numbers as [KEY]!!
    --see *sortbyKeys*cmp_alphanum*
    --for n in pairs(t) do table.insert(kSorted, n) end
    --table.sort(kSorted, f)

    local i = 0      -- iterator variable
    local iter = function()
        -- iterator function
        i = i + 1
        if tkSorted[i] == nil then
            return nil
        else
            return tkSorted[i], t[tkSorted[i]]
        end
    end
    return iter
end

local function sortbyKeys(t, tkSorted)
    --loads keys of (t) into values of tkSorted
    --and then sorts them
    --tkSorted has integer keys (see ipairs)
    ----FUNCTIONS for sortByKeys -------------
    local cmp_alphanum = function(op1, op2)
        local type1 = type(op1)
        local type2 = type(op2)
        if type1 ~= type2 then
            return type1 < type2
        else
            return op1 < op2
        end
    end
    ----END FUNCTIONS for sortByKeys ---------
    for n in pairs(t) do
        table.insert(tkSorted, n)
    end
    table.sort(tkSorted, cmp_alphanum)--table.sort(tkSorted)
end

local function load_modules(sPkgRoot, sWinPkgRoot)
    --attempt to load all found modules
    --Modules may depend on other modules
    --Supresses print, os.exit, rawset
    --Ignores *.luac
    PrRes("Functions Suspended, ")
    local orig = { osexit = _G.os.exit, print = _G.print, rawset = _G.rawset } --save original functions for later restoration

    _G.rawset = function(t, i, v)
        --orig.print ("rawset!")
        if _G[i] == v then
            orig.rawset(t, i, "_G[" .. tostring(i) .. "] !DUP!") --Don't allow global table to be copied
        else
            orig.rawset(t, i, v)
        end
    end
    _G.os.exit = function()
        error(999)
    end --don't exit whole program just this function

    _G.print = function()
    end --don't print

    local st = io.popen("find " .. sPkgRoot .. " -type f -iname '*.so' -o -type f -iname '*.lua'" .. " 2> nul")

    if not st:read(0) then
        --find didn't work try windows dir instead
        st = io.popen("dir /b /s " .. "\"" .. sWinPkgRoot .. "\\*.lua\" " .. "\"" .. sWinPkgRoot .. "\\*.so\" ") --simple output, subdir
    end
    if st:read(0) then
        for module in st:lines() do
            if (module) then
                if not string.find(module, ".luac", 1, true) then
                    --don't load precompiled code
                    local ok, res = pcall(loadfile(module))--protected call
                end
            end
        end
    end

    _G.os.exit = orig.osexit
    _G.print = orig.print
    _G.rawset = orig.rawset
    PrRes("Functions Restored, ")
end

local function dtTag(sType)
    --convert named type; 'number'.. to short type '[n]...'
    --if '?' supplied print out datatype key; number = [n]...
    local retType = "?"
    local typ = {
        ["nil"] = "nil",
        ["boolean"] = "b",
        ["number"] = "n",
        ["string"] = "s",
        ["userdata"] = "u",
        ["function"] = "f",
        ["thread"] = "thr",
        ["table"] = "t"
    }
    if sType == "?" then
        retType = "Datatypes: "
    end
    for k, v in pairs(typ) do
        if sType == k then
            retType = v
            break
        elseif (sType == "?") then
            retType = retType .. "  [" .. v .. "] = " .. k
        end
    end
    return " [" .. retType .. "] "
end

local function dump_Tables(tBase, sFunc, tSeen, tRet)
    --Based on: http://www.lua.org/cgi-bin/demo?globals
    --Recurse through tBase tables copying all found Tables
    local sSep = ""
    local ld = {}

    if sFunc ~= "" then
        sSep = "."
    end

    for k, v in pairs(tBase) do
        k = tostring(k)
        if has_value(modsBlacklist, k) then
            print("blacklisted module")
        else
            if k ~= "loaded" and type(v) == "table" and not tSeen[v] then
                tSeen[v] = sFunc
                tRet[sFunc .. sSep .. k] = a2m_m2a(v) --place all keys into ld[i]=value
                dump_Tables(v, sFunc .. sSep .. k, tSeen, tRet)
            end
        end
    end
    --print("tables dumped")
end

local function dump_Functions(tBase)
    --Based on: http://www.lua.org/cgi-bin/demo?globals
    --We already recursed through tBase copying all found tables
    --we look up the table by name and then (ab)use a2m_m2a() to load the address
    --after finding the table by address in tBase we will put the table address of tFuncs in its place

    for k, v in pairs(tBase) do
        local tTable = a2m_m2a(v)
        local tFuncs = {}
        --print(type(tTable))

        for key, val in pairs(tTable) do

            if has_value(funcsBlacklist, key) then
                print("blacklisted function or module")
            else
                if key ~= "loaded" then
                    tFuncs[dtTag(type(val)) .. tostring(key)] = val --put the name and value in our tFuncs table
                end
            end
        end
        tBase[k] = a2m_m2a(tFuncs) -- copy the address back to tBase
    end

    --print("functions dumped")
end

local function html_Table(tBase, tkSorted, sId, fHeader, sTitle, iCols, fCellCond, fCell, fFooter, fOut)
    --[[Prints HTML <table>
        tBase,    the table of items you want in your table [key] contains the cell data
        tkSorted, the key sorted values of tBase (tkSorted keys are (i) based (see: ipairs)
        sID,      ID of div tag
        fHeader,  function returning <DIV></DIV>
        sTitle,   title of the table
        iCols,    number of cells wide
        fCellCond,    if return (TRUE) cell is displayed, fCellCond(k, v, n, iCells, i)
        fCell,    function returning contents of cell
        fFooter,  function returning tags at the end of the </table>
        fOut,     function to print the table[integer]=HTML_DATA based output
    --]]
    local oTbl = {}
    local i = 1
    local strName = ""
    local iCells = 0
    local n = 0 --counts columns
    oTbl[i] = fHeader(sId, sTitle)
    i = i + 1
    oTbl[i] = "<table><tr><th colspan='" .. iCols .. "'>" .. sTitle .. "</th></tr>\r\n"
    for k, v in pairsByPairs(tBase, tkSorted) do

        strName = tostring(k)
        if fCellCond(k, v, n, iCells, i) then
            if n == 0 then
                i = i + 1
                oTbl[i] = "\t<tr>\r\n"
            end
            n = n + 1
            i = i + 1
            iCells = iCells + 1
            oTbl[i] = "\t\t" .. fCell(strName, v, sTitle) .. "\r\n"
            if n >= iCols then
                n = 0
                i = i + 1
                oTbl[i] = "\t</tr>\r\n"
            end
            fOut(oTbl, i)
            i = 0
        end
    end

    if n ~= 0 then
        i = i + 1
        oTbl[i] = "\t</tr>\r\n"
    end
    i = i + 1
    oTbl[i] = "</table>\r\n" .. fFooter(strName)
    fOut(oTbl, i)
    return iCells
end

local function html_function_tables(tBase, tkSortTbase, fOut, iCols)
    --print a table of functions for every module in tBase
    local strName = ""
    local iCt = 0
    local tFuncs = {}
    local tkSorted = {}

    ----FUNCTIONS for Funct Html-----------------------------------------------------
    local function fCellTrue(k)
        --return tostring(k) == strName
        return true
    end

    local function fTableCell(strName, value, sTitle)
        local sHref = ""
        local sType = type(value)
        local sPkg = string.match(sTitle, ".+%p(%a+%P)")
        local sVal = ""
        --strName = tostring(strName)
        if string.len(strName) > iMaxStr then
            strName = string.sub(strName, 1, iMaxStr) .. "....."  --Truncate strings longer than iMaxStr
        end
        if sPkg ~= nil and string.find(";debug;package;string;coroutine;io;math;os;table;", ";" .. sPkg .. ";") then
            sHref = "<a href='" .. sURLsearch .. string.sub(strName, 6) .. "'>?</a>" --remove [f] from beginning
        end

        if nil ~= string.find(";string;number;userdata;boolean;", sType, 1, true) then

            sVal = tostring(value)

            if string.len(sVal) > iMaxStr then
                sVal = string.sub(sVal, 1, iMaxStr) .. "....." --Truncate strings longer than iMaxStr
            end

            return "</tr><td colspan='" .. iCols .. "'>" .. sHref .. strName .. " : " .. sVal .. "</td><tr>"
        else
            return "<td><a>" .. strName .. "</a>" .. sHref .. "</td>"
        end
    end

    local function fPageAnchor(sId, strTitle)
        local sHref = ""
        local sAddr = ""
        local sModload = tQuery.modload
        if not sModload then
            sModload = ""
        end

        local sStyle = "'style='display:block;text-decoration: none"
        if os.getenv("SERVER_NAME") and os.getenv("SCRIPT_NAME") then
            sAddr = "http://" .. os.getenv("SERVER_NAME") .. "/" .. os.getenv("SCRIPT_NAME") .. "?modload=" .. sModload
            sHref = "<a href='" .. sAddr .. "&module=" .. strTitle .. sStyle .. "'>" .. "Module: " .. strTitle .. "</a>"
        else
            sHref = "Module: " .. strTitle
        end

        return "<div id='" .. sId .. "'style='color:#0000FF'><h3>" .. sHref .. "</h3></div>\r\n"
    end

    local function fPageFooter(strName)
        return "<p><a href='#toc'>^</a></p><BR /><BR />"
    end
    ----END FUNCTIONS for Funct Html--------------------------------------------------

    for key, val in pairsByPairs(tBase, tkSortTbase) do
        strName = tostring(key)
        tkSorted = {}
        tFuncs = a2m_m2a(val)
        sortbyKeys(tFuncs, tkSorted)

        iCt = iCt + html_Table(tFuncs, tkSorted, strName, fPageAnchor, strName, iCols, fCellTrue, fTableCell, fPageFooter, fOut)
    end
    return iCt
end

local function html_toc_tables(tBase, tkSortTbase, fOut, iCols)

    local iCt = 0

    ----FUNCTIONS for TOC Html-----------------------------------------------------
    local function fTableCell(strName)
        return "<td><a href='#" .. strName .. "'style='display:block;text-decoration: none'>" .. strName .. "</a></td>"
    end

    local function fCellTrue()
        return true
    end

    local function fFooter()
        return "<BR /><b>" .. dtTag("?") .. "</b><BR /><BR /><BR /><BR /><BR /><BR />"
    end

    local function fPageAnchor(sId, strTitle)
        return "<div id='" .. sId .. "'><p></p></div>\r\n"
    end
    ----END FUNCTIONS for TOC Html--------------------------------------------------

    iCt = html_Table(tBase, tkSortTbase, "toc", fPageAnchor, "* Modules Found * Lua Ver. " .. _VERSION, iCols, fCellTrue, fTableCell, fFooter, fOut)

    return iCt
end

local function main (sPackage)

    local tSeen = {}
    local tcBase = {}
    local tkSortCbase = {}
    local tMods = {}
    local tkSortMods = {}

    local iCtF = 0

    if not sPackage then
        sPackage = "_G"
    end

    putOutput({ --header for html document
        [1] = "<!DOCTYPE html>\r\n<html><head>\r\n<style>\r\n",
        [2] = "\ttable, th, td {border: 1px solid black;}\r\n",
        [3] = "\ttable tr:nth-child(even) {background-color: #C4C4C4;}\r\n",
        [4] = "\ttable tr:nth-child(odd) {background-color:#EFEFEF;}\r\n",
        [5] = "</style>\r\n</head><body>\r\n"
    })
    PrRes("Dump Tables: ")
    xpcall(function()
        dump_Tables(tableByName({ ["val"] = sPackage }), "", tSeen, tMods)
    end, errorHandler)
    tSeen = nil
    PrRes("ok, ")

    PrRes("Dump Functions: ")
    xpcall(function()
        dump_Functions(tMods)
    end, errorHandler)
    PrRes("ok, ")

    PrRes("Common Branches: ")
    get_common_branches(tMods, tcBase)
    PrRes("ok, ")

    PrRes("Sorting Branches: ")
    sortbyKeys(tcBase, tkSortCbase)
    sortbyKeys(tMods, tkSortMods)
    PrRes("ok, ")

    PrRes("Print TOC: ")
    iCtF = html_toc_tables(tcBase, tkSortCbase, putOutput, 3)
    tcBase = nil
    tkSortCbase = nil
    PrRes(iCtF .. " ok, ")

    PrRes("Print Functions: ")
    iCtF = html_function_tables(tMods, tkSortMods, putOutput, 6)
    PrRes(iCtF .. " ok, ")

end
----------------------------FUNCTIONS END--------------------------------------------------

if os.getenv("SERVER_NAME") == nil then
    sEnv = "other"
else
    --sEnv == web
    --Send response header as soon as we load
    io.write("Status: 200 OK\r\nKeep-Alive: timeout=60\r\nContent-Type:text/html\r\nLast-Modified:Sun, 11 Jan 2099 01:01:99 GMT\r\n\r\n") -- end of response)
end

if sQuery == "" then
    --load arguments from query string if web; or arg[] if not
    if sEnv == "web" then
        sQuery = os.getenv("QUERY_STRING")
    else
        --Load arguments from arg[] list arg[1]=arg[2]&arg[3]=arg[4]&..
        for k, v in pairs({ ... }) do
            sQuery = sQuery .. v
            if math.fmod(k, 2) == 0 then
                sQuery = sQuery .. "&"
            else
                sQuery = sQuery .. "="
            end
        end
    end
end

tQuery = parse_url(sQuery)
--[[print(sQuery)
for k,v in pairs(tQuery) do
print ("[", k ,"]=", v)
end]]

if sQuery ~= "modloadno" and tQuery.modload ~= "no" then
    PrRes("Load Modules: ")
    xpcall(function()
        load_modules(sPkgPath, sWpkgPath)
    end, errorHandler)
    --load_modules(sPkgPath)
    PrRes("ok, ")
end

PrRes("Main; ")
if sEnv ~= "web" then
    print("Fileout: " .. sFileOut)
    io.output(sFileOut)
end

local ok, res = pcall(main, tQuery.module)

if not ok then
    if sEnv ~= "web" then
        print("Status: 500 Internal Server Error\r\nContent-Type: text/plain\r\n\r\n" .. res .. "\r\n")
    else
        print("Error: " .. res)
    end
end

PrRes("DONE")

io.write("<p> Query: " .. sQuery .. ";; " .. sResults .. "</p>")