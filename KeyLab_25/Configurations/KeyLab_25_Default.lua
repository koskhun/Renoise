--[[----------------------------------------------------------------------------
-- Duplex.Arturia KeyLab 25
----------------------------------------------------------------------------]]--

-- default configuration of the Arturia KeyLab 25

--==============================================================================

duplex_configurations:insert {
  
  -- configuration properties
  name = "Default",
  pinned = true,

  -- device properties
  device = {
    class_name = "KeyLab_25",
    display_name = "KeyLab 25",
    device_port_in = "MIDIIN2 (KeyLab 25)",
    device_port_out = "MIDIOUT2 (KeyLab 25)",
    control_map = "Controllers/KeyLab_25/Controlmaps/KeyLab_25.xml",
    thumbnail = "Controllers/KeyLab_25/KeyLab_25.bmp",
    protocol = DEVICE_PROTOCOL.MIDI
  },

  applications = {
    Mixer = {
      mappings = {
        levels = {
          group_name = "FADERS",
        },
      },
      options = {
        follow_track = 1,
      }
    },
    Effect = {
      mappings = {
        parameters = {
          group_name = "KNOBS",
        },
      },
    },
    Transport = {
      mappings = {
        loop_pattern = {
          group_name = "TRANSPORT",
          index = 6,
        },
        goto_previous = {
          group_name = "TRANSPORT",
          index = 1,
        },
        goto_next = {
          group_name = "TRANSPORT",
          index = 2,
        },
        stop_playback = {
          group_name = "TRANSPORT",
          index = 3,
        },
        start_playback = {
          group_name = "TRANSPORT",
          index = 4,
        },
        edit_mode = {
          group_name = "TRANSPORT",
          index = 5, 
        },
      },
    },
  },
}
