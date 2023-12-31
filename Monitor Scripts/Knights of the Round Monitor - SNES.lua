-- Set up montor --

displaytimers = true
displayRNGCurrent = true
displayscroll = true
player1stats = true
enemystats = true

-- Set memory domain --
memory.usememorydomain("WRAM")

function stats()
  -- Main Timer count
  t1 = memory.readbyte(0xC36)
  -- Secondary timer count
  t2 = memory.readbyte(0xC37)
  RNG = memory.readbyte(0xD5F)
  -- Scroll X counter
  Scroll_X = memory.readbyte(0xC812)
  -- P1 Stats
  P1_HP = memory.readbyte(0x4008)
  P1_HP_LB = memory.readbyte(0x400A)
  P1_X = memory.readbyte(0x4012)
  P1_X_Sub = memory.readbyte(0x4011)
  P1_Y = memory.readbyte(0x401A)
  P1_Y_Sub = memory.readbyte(0x4019)
  P1_Jump = memory.readbyte(0x4016)
  P1_Jump_Sub = memory.readbyte(0x4015)
  -- E1 stats
  E1_HP = memory.readbyte(0x5E08)
  E1_HP_ExtraBars = memory.readbyte(0x5E07)
  E1_HP_LB = memory.readbyte(0x5E0A)
  -- E2 stats
  E2_HP = memory.readbyte(0x5C08)
  E2_HP_ExtraBars = memory.readbyte(0x5C07)
  E2_HP_LB = memory.readbyte(0x5C0A)
  -- E3 stats
  E3_HP = memory.readbyte(0x6008)
  E3_HP_ExtraBars = memory.readbyte(0x6007)
  E3_HP_LB = memory.readbyte(0x600A)
  if displaytimers == true then
    gui.text(560, 45, 'T1: ' .. t1)
    gui.text(560, 60, 'T2: ' .. t2)
  end
  if displayRNGCurrent == true then
    gui.text(560, 75, 'RNG: ' .. RNG)
  end
  if displayscroll == true then
    gui.text(560, 90, 'Scroll X: ' .. Scroll_X)
  end
  if player1stats == true then
    gui.text(560, 120, 'Player 1')
    gui.text(560, 125, '________________')
    gui.text(560, 145, 'HP: ' .. P1_HP)
    gui.text(640, 145, 'HP-LB: ' .. P1_HP_LB)
    gui.text(560, 165, 'X: ' .. P1_X)
    gui.text(640, 165, 'X Sub: ' .. P1_X_Sub)
    gui.text(560, 180, 'Y: ' .. P1_Y)
    gui.text(640, 180, 'Y Sub: ' .. P1_Y_Sub)
    gui.text(560, 195, 'J: ' .. P1_Jump)
    gui.text(640, 195, 'J Sub: ' .. P1_Jump_Sub)
  end
  if enemystats == true then
    gui.text(560, 220, 'Enemy 1')
    gui.text(560, 225, '________')
    gui.text(560, 245, 'HP: ' .. E1_HP)
    gui.text(560, 265, 'HP-EX: ' .. E1_HP_ExtraBars)
    gui.text(560, 280, 'HP-LB: ' .. E1_HP_LB)
    gui.text(660, 220, 'Enemy 2')
    gui.text(660, 225, '________')
    gui.text(660, 245, 'HP: ' .. E2_HP)
    gui.text(660, 265, 'HP-EX: ' .. E2_HP_ExtraBars)
    gui.text(660, 280, 'HP-LB: ' .. E2_HP_LB)
    gui.text(760, 220, 'Enemy 3')
    gui.text(760, 225, '________')
    gui.text(760, 245, 'HP: ' .. E3_HP)
    gui.text(760, 265, 'HP-EX: ' .. E3_HP_ExtraBars)
    gui.text(760, 280, 'HP-LB: ' .. E3_HP_LB)
  end
end

while true do
  client.SetGameExtraPadding(0,0,250,0)
  stats()
	emu.frameadvance();
end
