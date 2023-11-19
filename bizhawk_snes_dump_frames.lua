--mapping = [0, 2, 1, 3, 4, 6, 5, 7];   -- p1d0, p1d1, p2d0, p2d1
--mapping = {0, 1, 2, 3, 4, 5, 6, 7};  -- p1i1, p1i0, p2i1, p2i0

--possible bug: you may need to add a frame to the beginning of input
-- bit = (require "migration_helpers").EmuHawk_pre_2_9_bit();

joymap = {}
joymap["B"]         = 0
joymap["Y"]         = 1
joymap["Select"]    = 2
joymap["Start"]     = 3
joymap["Up"]        = 4
joymap["Down"]      = 5
joymap["Left"]      = 6
joymap["Right"]     = 7
joymap["A"]         = 8
joymap["X"]         = 9
joymap["L"]         = 10
joymap["R"]         = 11
joymap["et"]     = 99 -- Reset
joymap["er"]     = 98 -- Power
joymap["Toggle Multitap"] = 97


file_suffix = "frame.r16m"


--[[
while true do
    print(movie.getinput(emu.framecount()))
    emu.frameadvance()
end
]]

-- a movie needs to be playing to do anything
if movie.mode() ~= "PLAY" then
    error("error movie not playing - run this script after movie started and paused")
end

-- get r16m filename
_, _, path, filename, ext = string.find(movie.filename(), "(.-)([^\\/]-%.?)([^%.\\/]*)$")

-- open for writing
fh, err = io.open(path..filename..file_suffix, "wb")
if not fh then
    error("error opening output file: "..err)
end
print("dumping to "..path..filename..file_suffix)

dumpfile = fh
pollcount = 0
frame = 0

fh = nil
err = nil

while true do
    if dumpfile then
        if movie.mode() ~= "PLAY" and dumpfile then
            dumpfile:close()
            dumpfile = nil
            print("dumping completed")
        elseif not emu.islagged() then
            local p1 = 0
            local p2 = 0
            local p3 = 0
            local p4 = 0
            local p5 = 0
            local p6 = 0
            local p7 = 0
            local p8 = 0
            local p1a = 0
            local p2a = 0
            local p3a = 0
            local p4a = 0
            local p5a = 0
            local p6a = 0
            local p7a = 0
            local p8a = 0
            local input = movie.getinput(emu.framecount())
            local bytenum

            pollcount = pollcount + 1

            -- copy input data to bit data
            for k, v in pairs(input) do
                local player = string.sub(k, 1, 2)
                local id     = string.sub(k, 4, string.len(k))
                local mod    = joymap[id]

                if mod < 8 then bytenum = 1; elseif mod < 16 then bytenum = 2; end

                if input[k] == true then
                    if bytenum == 1 then
                        if player == "P1" then p1 = (p1 | (1 << 7 - mod)); end
                        if player == "P2" then p2 = (p2 | (1 << 7 - mod)); end
                        if player == "P3" then p3 = (p3 | (1 << 7 - mod)); end
                        if player == "P4" then p4 = (p4 | (1 << 7 - mod)); end
                        if player == "P5" then p5 = (p5 | (1 << 7 - mod)); end
                        if player == "P6" then p6 = (p6 | (1 << 7 - mod)); end
                        if player == "P7" then p7 = (p7 | (1 << 7 - mod)); end
                        if player == "P8" then p8 = (p8 | (1 << 7 - mod)); end
                    end
                    if bytenum == 2 then
                        mod = mod - 8
                        if player == "P1" then p1a = (p1a | (1 << 7 - mod)); end
                        if player == "P2" then p2a = (p2a | (1 << 7 - mod)); end
                        if player == "P3" then p3a = (p3a | (1 << 7 - mod)); end
                        if player == "P4" then p4a = (p4a | (1 << 7 - mod)); end
                        if player == "P5" then p5a = (p5a | (1 << 7 - mod)); end
                        if player == "P6" then p6a = (p6a | (1 << 7 - mod)); end
                        if player == "P7" then p7a = (p7a | (1 << 7 - mod)); end
                        if player == "P8" then p8a = (p8a | (1 << 7 - mod)); end
                    end
                end
            end

            -- write bit data
            dumpfile:write(string.char(
                (p1 & 0xff),
                (p1a & 0xff),
                (p2 & 0xff),
                (p2a & 0xff),
                (p3 & 0xff),
                (p3a & 0xff),
                (p4 & 0xff),
                (p4a & 0xff),
                (p5 & 0xff),
                (p5a & 0xff),
                (p6 & 0xff),
                (p6a & 0xff),
                (p7 & 0xff),
                (p7a & 0xff),
                (p8 & 0xff),
                (p8a & 0xff)
            ));

            if pollcount % 1024 == 0 then
                print("wrote "..tostring(pollcount).." frames")
            end
        end
    end

    emu.frameadvance()
end
