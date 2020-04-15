--[[----------------------------------------------------------------------------
-- Duplex.NanoKontrol2
----------------------------------------------------------------------------]]--

duplex_configurations:insert {

  -- configuration properties
  name = "nanoKONO",
  pinned = true,

  -- device properties
  device = {
    class_name = "NanoKontrol",          
    display_name = "nanoKONO",
    device_port_in = "nanoKONTROL Studio",
    device_port_out = "nanoKONTROL Studio",
    control_map = "Controllers/nanoKONO/Controlmaps/nanoKONO.xml",
    thumbnail = "Controllers/nanoKONO/nanoKONO.bmp",
    protocol = DEVICE_PROTOCOL.MIDI
  },
  
  applications = {
    Mixer = {
      mappings = {
        solo = {
          group_name = "Buttons2",
        },
        mute = {
          group_name = "Buttons1",
        },
        levels = {
          group_name = "Faders",
        },
      },
      options = {
        invert_mute = 1,
        follow_track = 1,
        take_over_volume = 1,
        pre_post = 2,
      }
    },
    Effect = {
      mappings = {
        parameters = {
          group_name = "Encoders",
        },
        device_prev = {
          group_name = "MARKER",
          index = 2,
        },
        device_next = {
          group_name = "MARKER",
          index = 3,
        },
      }
    },
   -- Recorder = {
   --   mappings = {
   --     recorders = {
   --       group_name = "Buttons3",
   --     },
   --     sliders = {
   --       group_name = "Wheel",
   --     },
   --   },
   --   options = {
   --      loop_mode = 2,
   --      auto_seek = 2,
   --      beat_sync = 1,
   --      trigger_mode = 1,
   --      autostart = 4,
   --
   --   }
   -- },
   -- Navigator = {
   --   mappings = {
   --     blockpos = {
   --       group_name = "Transport",
   --       index = 1,
   --     },
   --     prev_block = {
   --       group_name = "Wheel",
   --       index = 1,
   --     },
   --     next_block = {
   --       group_name = "Wheel",
   --       index = 1,
   --     },
   --   }
   -- },
   -- NotesOnWheels = {
   --   mappings = {
   --    retrig_sliders = {
   --      group_name = "Wheel",
   --      index = 1,
   --    },
   --   }
   -- },
    Transport = {
      mappings = {
        loop_pattern = {
          group_name = "CYCLE",
          index = 1,
        },
        goto_previous = {
          group_name = "Pattern and Track",
          index = 1,
        },
        goto_next = {
          group_name = "Pattern and Track",
          index = 2,
        },
        block_loop = {
          group_name = "Transport",
          index = 1
        },
        stop_playback = {
          group_name = "Transport",
          index = 2,
        },
        start_playback = {
          group_name = "Transport",
          index = 3,
        },
        edit_mode = {
          group_name = "Transport",
          index = 4,
        },
        follow_player = {
          group_name = "MARKER",
          index = 1,
        },
      },
      options = {
        pattern_switch = 2,
        pattern_play = 2,
      }
    },
    TrackSelector = {
      mappings = {
        prev_track = {
          group_name = "Pattern and Track",
          index = 3,
        },
        next_track = {
          group_name = "Pattern and Track",
          index = 4,
        },
        select_track = {
          group_name = "Buttons4",
        },
      },
    },
  }
}



