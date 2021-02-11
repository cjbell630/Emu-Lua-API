# desmume #
### agg ###
```java
fillColor function:000000000CB667B0
text function:000000000CB66D20
setFont function:000000000CB67020
ellipse function:000000000CB67050
triangle function:000000000CB66CF0
lineWidth function:000000000CB665D0
rectangle function:000000000CB66CC0
roundedRect function:000000000CB66E10
line function:000000000CB67140
lineColor function:000000000CB66FF0
arc function:000000000CB66570
noFill function:000000000CB66900
star function:000000000CB66960
curve function:000000000CB66E40
noLine function:000000000CB66B40

```
### bit ###
```java
band function(x1 [,x2...])
rshift function(x, n)
bor function(x1 [,x2...])
bnot function(x)
bswap function(x)
bxor function(x1 [,x2...])
tobit function(x)
ror function(x, n)
lshift function(x, n)
tohex function(x [,n])
rol function(x, n)
arshift function(x, n)

```
### emu ###
```java
registerexit function(func)
lagged function()
print function(...)
registerstart function(func)
lagcount function()
registermenustart function(func)
unpause function()
emulateframefastnoskipping function()
setmenuiteminfo function(menuItem, infoTable)
wait function()
emulateframe function()
addmenu function(menuName, menuEntries)
registerafter function(func)
openscript function(filename)
atframeboundary function()
emulating function()
persistglobalvariables function(variabletable)
emulateframefast function()
frameadvance function()
message function(str)
redraw function()
speedmode function(mode)
framecount function()
emulateframeinvisible function()
registerbefore function(func)
pause function()
reset function()

```
### stylus ###
```java
peek function()
read function()
write function(table)
set function(table)
get function()

```
### memory ###
```java
registerexec function(address,[size=2,][cpuname="main",]func)
registerexecute function(address,[size=2,][cpuname="main",]func)
readshortunsigned function(address)
readbyte function(address)
registerrun function(address,[size=2,][cpuname="main",]func)
readword function(address)
register function(address,[size=1,][cpuname="main",]func)
readlongsigned function(address)
writedword function(address,value)
writelong function(address,value)
setregister function(cpu_dot_registername_string,value)
readdword function(address)
writeshort function(address,value)
registerread function(address,[size=1,][cpuname="main",]func)
readbytesigned function(address)
readlongunsigned function(address)
writebyte function(address,value)
vram_readword function(address)
readdwordsigned function(address)
vram_writeword function(address,value)
registerwrite function(address,[size=1,][cpuname="main",]func)
readlong function(address)
getregister function(cpu_dot_registername_string)
writeword function(address,value)
isvalid function(address)
readbyterange function(address,length)
readwordsigned function(address)
readdwordunsigned function(address)
readshortsigned function(address)
readwordunsigned function(address)
readshort function(address)
readbyteunsigned function(address)

```
### movie ###
```java
active function()
rerecordcounting function([enabled])
readonly function()
rerecordcount function()
recording function()
getname function()
mode function()
play function([filename])
playing function()
setreadonly function(readonly)
replay function()
open function([filename])
framecount function()
getreadonly function()
name function()
playback function([filename])
close function()
stop function()
setrerecordcount function()
length function()

```
### savestate ###
```java
save function(location[,option])
create function([location])
load function(location[,option])

```
### input ###
```java
registerhotkey function(keynum,func)
popup function(message[,type="yesno"[,icon="question"]])
read function()
get function()

```
### joypad ###
```java
peek function()
write function(buttonTable)
set function(buttonTable)
peekup function()
getdown function()
peekdown function()
read function()
readup function()
readdown function()
getup function()
get function()

```
### sound ###
```java
clear function()

```
### gui ###
```java
register function(func)
opacity function(alpha_0_to_1)
box function(x1,y1,x2,y2[,fill[,outline]])
drawtext function(x,y,str[,color="white"[,outline="black"]])
line function(x1,y1,x2,y2[,color="white"[,skipfirst=false]])
image function([dx=0,dy=0,]gdimage[,sx=0,sy=0,width,height][,alphamul])
drawimage function([dx=0,dy=0,]gdimage[,sx=0,sy=0,width,height][,alphamul])
drawrect function(x1,y1,x2,y2[,fill[,outline]])
drawbox function(x1,y1,x2,y2[,fill[,outline]])
rect function(x1,y1,x2,y2[,fill[,outline]])
readpixel function(x,y)
gdoverlay function([dx=0,dy=0,]gdimage[,sx=0,sy=0,width,height][,alphamul])
parsecolor function(color)
writepixel function(x,y[,color="white"])
text function(x,y,str[,color="white"[,outline="black"]])
getpixel function(x,y)
drawpixel function(x,y[,color="white"])
drawline function(x1,y1,x2,y2[,color="white"[,skipfirst=false]])
transparency function(transparency_4_to_0)
setpixel function(x,y[,color="white"])
redraw function()
osdtext function:000000000CB61AE0
gdscreenshot function([whichScreen='both'])
pixel function(x,y[,color="white"])
popup function(message[,type="ok"[,icon="message"]])

```
