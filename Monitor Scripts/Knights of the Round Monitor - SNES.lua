-- Set up monitor --

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
    gui.text(20, 45, 'T1: ' .. t1)
    gui.text(20, 60, 'T2: ' .. t2)
  end
  if displayRNGCurrent == true then
    gui.text(20, 75, 'RNG: ' .. RNG)
  end
  if displayscroll == true then
    gui.text(20, 90, 'Scroll X: ' .. Scroll_X)
  end
  if player1stats == true then
    gui.text(20, 120, 'Player 1')
    gui.text(20, 125, '________________')
    gui.text(20, 145, 'HP: ' .. P1_HP)
    gui.text(120, 145, 'HP-LB: ' .. P1_HP_LB)
    gui.text(20, 165, 'X: ' .. P1_X)
    gui.text(120, 165, 'X Sub: ' .. P1_X_Sub)
    gui.text(20, 180, 'Y: ' .. P1_Y)
    gui.text(120, 180, 'Y Sub: ' .. P1_Y_Sub)
    gui.text(20, 195, 'J: ' .. P1_Jump)
    gui.text(120, 195, 'J Sub: ' .. P1_Jump_Sub)
  end
  if enemystats == true then
    gui.text(20, 220, 'Enemy 1')
    gui.text(20, 225, '________')
    gui.text(20, 245, 'HP: ' .. E1_HP)
    gui.text(20, 265, 'HP-EX: ' .. E1_HP_ExtraBars)
    gui.text(20, 280, 'HP-LB: ' .. E1_HP_LB)
    gui.text(120, 220, 'Enemy 2')
    gui.text(120, 225, '________')
    gui.text(120, 245, 'HP: ' .. E2_HP)
    gui.text(120, 265, 'HP-EX: ' .. E2_HP_ExtraBars)
    gui.text(120, 280, 'HP-LB: ' .. E2_HP_LB)
    gui.text(220, 220, 'Enemy 3')
    gui.text(220, 225, '________')
    gui.text(220, 245, 'HP: ' .. E3_HP)
    gui.text(220, 265, 'HP-EX: ' .. E3_HP_ExtraBars)
    gui.text(220, 280, 'HP-LB: ' .. E3_HP_LB)
  end
end

while true do
  client.SetGameExtraPadding(150,0,0,0)
  stats()
	emu.frameadvance();
end
