-- Set up montor --

displaytimers = true
displayRNGCurrent = true

function stats()
  -- Main Timer count
  t1 = memory.readbyte(0xC36)
  -- Secondary timer count
  t2 = memory.readbyte(0xC37)
  RNG = memory.readbyte(0xD5F)
  if displaytimers == true then
    gui.text(0, 45, 'T1: ' .. t1)
    gui.text(0, 60, 'T2: ' .. t2)
  end
  if displayRNGCurrent == true then
    gui.text(0, 220, 'RNG: ' .. RNG)
  end
end

while true do
  stats()
	emu.frameadvance();
end
