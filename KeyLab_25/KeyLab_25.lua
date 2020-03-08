
-- Duplex.KeyLab 25

class "KeyLab_25" (MidiDevice)


keylab_btn_sysex_ref = {
-- note,sysex,monocolour

  {"G-6",0x6A,true}, --transport -stop
  {"G#6",0x6B,true}, --transport -playPause
  {"A-6",0x6C,true}, --transport -record
  {"A#6",0x6E,true}, --previous track
  {"B-6",0x6D,true}, --next track
  
--[[  
  {"D-7",0x1A,true}, --center -left ?? SoundMode ??
  {"D#7",0x1B,true}, --center -right ?? MultiMode ??
  {"G-6",0x6A,true}, --transport -reverse
  {"G#6",0x6B,true}, --transport -forward
    
  {"D-6",0x6F,true}, --transport -loop
  {"C-1",0x22,false,false}, --SoundMode -Switch 1
  {"C#1",0x23,false,false}, --SoundMode -Switch 2
  {"D-1",0x24,false,false}, --SoundMode -Switch 3
  {"D#1",0x25,false,false}, --SoundMode -Switch 4
  {"E-1",0x26,false,false}, --SoundMode -Switch 5
  {"F-1",0x27,false,false}, --SoundMode -Switch 6
  {"F#1",0x28,false,false}, --SoundMode -Switch 7
  {"G-1",0x29,false,false}, --SoundMode -Switch 8 
  {"B--1",0x60,true,false}, --SoundMode -Track 1 
  {"G-0",0x61,true,false}, --MultiMode -Track 2
  {"D#-1",0x62,true,false}, --MultiMode -Track 3 
  {"D-5",0x63,true,false}, --MultiMode -Track 4
  {"D#5",0x64,true,false}, --MultiMode -Track 5
  {"G#5",0x65,true,false}, --MultiMode -Track 6
  {"D#6",0x66,true,false}, --MultiMode -Track 7
  {"E-6",0x67,true,false}, --MultiMode -Track 8 
  {"F-6",0x68,true,false}, --SoundMode+MultiMode? -Bank 1
  {"A-5",0x69,true,false}, --SoundMode+MultiMode? -Bank 2
--]]
}


keylab_color = {
  {0x0f,0x00,0x00},
  {0x00,0x0f,0x00},
}
         
function KeyLab_25:__init(display_name, message_stream, port_in, port_out)

  MidiDevice.__init(self, display_name, message_stream, port_in, port_out)
  
  print("Keylab Ready")

end

--[[

function Arturia_Keylab_Mkii_49:start_app()
  if not Application.start_app(self) then
    return
  end
  print("Keylab Started")
end

--]]



--[[

function Arturia_Keylab_Mkii_49:output_value(pt,xarg,ui_obj)
  
  --if xarg.skip_echo then
    --- parameter only exist in the virtual ui
  --  return Device.output_value(self,pt,xarg,ui_obj)
  --else
    
  local value,skip_hardware = nil,false
  local val_type = type(pt.val)

  if (val_type == "number") then
    value,skip_hardware = self:output_number(pt,xarg,ui_obj)

  elseif (val_type == "boolean") then
    value,skip_hardware = self:output_boolean(pt,xarg,ui_obj)

  elseif (val_type == "string") then
    value,skip_hardware = self:output_text(pt,xarg,ui_obj)

  elseif (val_type == "table") then

    -- when the value is a table, we iterate through each value 
    -- and call the appropriate methods. 

    value = table.create()
    for _,v in ipairs(pt.val) do

      local pt2 = {
        text = pt.text,
        color = pt.color,
        val = v,
      }

      local value2,skip2 = nil,false
      local val_type2 = type(v)

      if (val_type2 == "number") then
        value2,skip2 = self:output_number(pt2,xarg,ui_obj)

      elseif (val_type2 == "boolean") then
        value2,skip2 = self:output_boolean(pt2,xarg,ui_obj)

      elseif (val_type2 == "text") then
        value2,skip2 = self:output_text(pt2,xarg,ui_obj)

      end
      value:insert(value2)

      if (skip2) then
        skip_hardware = true
      end
    end
  end

--]]

--[[

  -- sysex send
  local sysex_num = nil
  local monocolor = nil
  local keylab_btn_sysex_ref_num = nil
  local sysex_hex = 0x10 -- 10 mono 16 colour
  
  -- loop to get button
  for i=1, table.maxn(keylab_btn_sysex_ref) do
    if(keylab_btn_sysex_ref[i][1] == xarg.value)then
      sysex_num = keylab_btn_sysex_ref[i][2]
      monocolor = keylab_btn_sysex_ref[i][3]
      keylab_btn_sysex_ref_num = i
 
      break
    end
  end
    
  -- if non value  
  if(sysex_num == nil) then 
    print(xarg.value, " is not available")
    return value,skip_hardware
  end
  
  --]]
    
  --[[
  if(keylab_btn_sysex_ref_num > 8) then
    -- toggle select
    
    keylab_btn_sysex_ref[keylab_btn_sysex_ref_num][4] = pt.val
    print("toggle on ", value)
      
    for k=9,table.maxn(keylab_btn_sysex_ref)  do
      print(keylab_btn_sysex_ref[k][1], " - ",keylab_btn_sysex_ref[k][4])
      if(keylab_btn_sysex_ref[k][4] == true) then --cur value
        if(keylab_btn_sysex_ref[k][3] == true) then --mono
          self:send_sysex_message(0x00,0x20,0x6B,0x7F,0x42,0x02,0x00, 0x10, keylab_btn_sysex_ref[k][2],keylab_color[1][1])
        else
          self:send_sysex_message(0x00,0x20,0x6B,0x7F,0x42,0x02,0x00, 0x16, keylab_btn_sysex_ref[k][2],keylab_color[1][1],keylab_color[1][2],keylab_color[1][3])
        end
      else
        if(keylab_btn_sysex_ref[k][3] == true) then 
          self:send_sysex_message(0x00,0x20,0x6B,0x7F,0x42,0x02,0x00, 0x10, keylab_btn_sysex_ref[k][2],keylab_color[2][1])
        else
          self:send_sysex_message(0x00,0x20,0x6B,0x7F,0x42,0x02,0x00, 0x16, keylab_btn_sysex_ref[k][2],keylab_color[2][1],keylab_color[2][2],keylab_color[2][3])
        end
      end
    end
    
    return value,true
  end   
  --]]
  
  --[[
  
  --normal
  if(monocolor == true) then 
    self:send_sysex_message(0x00,0x20,0x6B,0x7F,0x42,0x02,0x00, 0x10, sysex_num,pt.color[1])
  end
  if(monocolor == false) then
    self:send_sysex_message(0x00,0x20,0x6B,0x7F,0x42,0x02,0x00, 0x16, sysex_num,pt.color[1],pt.color[2],pt.color[3])
  end

  print("normal ", value)  
  return value,true
end

--]]

