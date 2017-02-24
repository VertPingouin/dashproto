return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 24,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 165,
  properties = {},
  tilesets = {
    {
      name = "graveyard",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "../assets/pics/graveyard.png",
      imagewidth = 80,
      imageheight = 80,
      transparentcolor = "#f4bdb0",
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 25,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "bg",
      x = 0,
      y = 0,
      width = 32,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["layer"] = 0
      },
      encoding = "lua",
      data = {
        3, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 2, 3, 3, 2, 3, 1, 1, 2, 2, 3, 1, 3, 1, 3, 1, 3, 1, 2, 2, 2, 2,
        3, 1, 2, 1, 2, 2, 2, 2, 1, 3, 1, 1, 3, 3, 2, 2, 1, 1, 1, 1, 2, 1, 3, 1, 1, 3, 2, 2, 3, 2, 3, 2,
        3, 2, 2, 2, 3, 1, 2, 3, 3, 2, 1, 3, 2, 3, 3, 1, 3, 2, 1, 3, 2, 3, 2, 3, 2, 0, 1, 1, 1, 2, 3, 1,
        2, 3, 3, 3, 2, 3, 3, 2, 1, 1, 2, 2, 1, 1, 3, 3, 1, 3, 3, 1, 3, 1, 2, 3, 2, 3, 2, 2, 2, 3, 1, 1,
        1, 1, 1, 2, 2, 3, 1, 2, 2, 2, 3, 3, 2, 1, 2, 2, 1, 3, 1, 3, 2, 1, 3, 2, 1, 1, 3, 3, 2, 2, 3, 3,
        3, 1, 1, 2, 3, 2, 1, 1, 1, 1, 1, 3, 3, 1, 2, 2, 1, 2, 2, 3, 2, 1, 3, 3, 3, 1, 3, 3, 3, 3, 1, 3,
        1, 2, 2, 2, 1, 2, 3, 2, 2, 1, 1, 1, 2, 1, 3, 2, 2, 3, 1, 3, 1, 1, 3, 1, 1, 2, 3, 3, 3, 1, 3, 1,
        1, 3, 2, 3, 1, 2, 1, 1, 3, 2, 2, 1, 1, 1, 2, 1, 3, 2, 2, 2, 2, 2, 2, 3, 3, 2, 1, 3, 1, 1, 3, 3,
        3, 3, 1, 2, 1, 1, 3, 3, 2, 3, 3, 2, 1, 1, 3, 1, 2, 2, 2, 2, 2, 3, 1, 1, 2, 2, 1, 3, 3, 2, 2, 2,
        1, 2, 1, 3, 3, 1, 1, 1, 3, 3, 1, 2, 1, 1, 3, 2, 3, 1, 1, 3, 3, 2, 2, 3, 1, 1, 1, 3, 1, 2, 1, 3,
        3, 3, 2, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1, 3, 3, 2, 3, 1, 1, 2, 2, 2, 1, 1, 3, 1, 3, 2, 2, 3, 3, 3,
        3, 3, 2, 1, 3, 1, 1, 2, 2, 3, 3, 1, 3, 2, 1, 1, 2, 3, 1, 2, 3, 3, 1, 3, 3, 1, 1, 3, 3, 1, 1, 1,
        3, 3, 2, 2, 2, 1, 3, 1, 1, 2, 3, 3, 3, 1, 2, 1, 3, 3, 1, 3, 1, 3, 3, 2, 1, 3, 3, 1, 2, 2, 3, 3,
        3, 3, 2, 2, 2, 1, 1, 2, 1, 1, 3, 1, 1, 2, 1, 3, 3, 1, 2, 3, 1, 1, 2, 1, 3, 3, 3, 3, 1, 2, 3, 2,
        1, 1, 1, 3, 2, 2, 2, 2, 2, 3, 1, 3, 3, 2, 3, 2, 2, 1, 2, 2, 1, 1, 1, 1, 3, 3, 2, 3, 3, 3, 3, 3,
        2, 3, 1, 2, 1, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 3, 3, 3, 1, 1, 3, 3, 1, 2, 1, 3, 1, 3, 1, 1, 3, 1,
        1, 3, 1, 2, 1, 1, 3, 3, 2, 2, 2, 3, 3, 3, 2, 3, 1, 3, 1, 1, 2, 2, 2, 1, 3, 2, 2, 2, 1, 1, 1, 2,
        3, 2, 1, 1, 2, 1, 3, 3, 3, 3, 1, 2, 1, 1, 3, 3, 2, 3, 1, 2, 1, 2, 2, 1, 2, 3, 2, 2, 3, 1, 3, 2,
        3, 1, 2, 2, 2, 2, 2, 3, 2, 1, 1, 3, 3, 1, 2, 1, 3, 1, 2, 3, 3, 3, 1, 2, 2, 3, 1, 1, 3, 3, 2, 2,
        3, 2, 3, 2, 3, 1, 2, 2, 3, 2, 3, 3, 2, 2, 3, 3, 1, 3, 2, 2, 1, 3, 3, 3, 3, 1, 3, 3, 1, 2, 1, 2,
        3, 1, 2, 1, 3, 3, 3, 1, 3, 2, 2, 1, 1, 2, 1, 2, 3, 3, 2, 1, 1, 3, 2, 2, 3, 1, 1, 3, 1, 3, 3, 2,
        3, 2, 3, 3, 3, 3, 1, 2, 3, 2, 3, 1, 3, 2, 2, 3, 1, 1, 2, 3, 3, 3, 1, 1, 2, 1, 2, 1, 3, 2, 2, 3,
        1, 2, 3, 2, 2, 1, 2, 1, 1, 2, 3, 1, 3, 2, 2, 3, 1, 1, 1, 2, 1, 1, 2, 3, 3, 1, 1, 2, 1, 3, 1, 3,
        1, 2, 3, 1, 2, 1, 2, 3, 1, 2, 2, 2, 2, 1, 3, 3, 1, 1, 1, 1, 1, 1, 1, 3, 1, 2, 1, 3, 2, 2, 3, 1
      }
    },
    {
      type = "tilelayer",
      name = "l1",
      x = 0,
      y = 0,
      width = 32,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["layer"] = 1
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 4, 4, 12, 12, 13, 12, 13, 12, 12, 13, 13, 13, 13, 13, 13, 13, 12, 12, 13, 13, 13, 13, 13, 12, 12,
        0, 0, 0, 0, 0, 0, 4, 4, 4, 13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        0, 0, 0, 0, 0, 4, 4, 4, 4, 13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 14, 10, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12,
        0, 0, 0, 0, 4, 4, 4, 4, 4, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12,
        0, 0, 0, 4, 4, 4, 4, 4, 4, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13, 20, 4, 4, 14, 10, 4, 4, 4, 4, 4, 12,
        0, 0, 4, 4, 4, 4, 4, 4, 4, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12, 20, 4, 4, 12, 25, 4, 4, 4, 4, 4, 13,
        4, 4, 4, 4, 4, 4, 4, 4, 4, 13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        12, 20, 4, 4, 4, 4, 4, 4, 4, 13, 5, 15, 15, 15, 15, 15, 15, 15, 15, 15, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 12, 12, 12, 12, 12, 13, 12, 12, 13, 12, 13, 12, 25, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 5, 15, 15, 15, 10, 4, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 10, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        12, 12, 13, 12, 12, 25, 4, 13, 12, 13, 13, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12, 20, 4, 4, 4, 4, 4, 4, 4, 4, 12,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12, 25, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 20, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 13,
        13, 5, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 12,
        12, 13, 12, 12, 13, 13, 12, 12, 13, 12, 13, 12, 12, 13, 13, 13, 13, 13, 13, 13, 12, 12, 12, 12, 12, 12, 13, 12, 13, 12, 12, 12
      }
    },
    {
      type = "tilelayer",
      name = "l2",
      x = 0,
      y = 0,
      width = 32,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["layer"] = 2
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 23, 24, 0, 0, 7, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 16, 17, 18, 19, 0, 0, 0, 0, 7, 6, 0, 0, 0, 0, 0, 0, 11, 11, 11, 11, 0,
        0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 21, 22, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 11, 9, 8, 9, 0,
        0, 0, 0, 0, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 11, 8, 11, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0,
        18, 19, 0, 0, 0, 0, 0, 0, 0, 7, 0, 8, 0, 0, 8, 9, 11, 0, 7, 7, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0,
        23, 24, 0, 0, 0, 7, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 6, 7, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 6, 7, 0, 0, 7, 0, 0, 0, 0, 0, 0, 7, 7, 7, 0, 7, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 6,
        0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 6, 7, 7, 0, 0,
        6, 0, 7, 6, 7, 0, 0, 0, 0, 8, 8, 8, 9, 11, 8, 8, 11, 8, 8, 11, 9, 0, 0, 0, 7, 6, 7, 7, 7, 7, 7, 7,
        6, 0, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 11, 8, 0, 0, 0, 9, 8, 0, 0, 0, 7, 7, 6, 0, 0, 0, 7, 7, 6, 0,
        7, 6, 6, 0, 0, 6, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 6, 0, 0, 0, 0, 0, 0, 6, 7, 6,
        0, 7, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 16, 17, 0, 0, 0, 0, 0, 6, 7, 0, 16, 17, 11, 9, 8, 8, 0, 9, 8, 8, 0, 0, 0, 0, 0, 0, 18, 19, 18, 19, 0,
        6, 21, 22, 0, 0, 0, 6, 7, 6, 6, 0, 21, 22, 8, 11, 11, 11, 0, 0, 8, 11, 0, 0, 0, 0, 0, 0, 23, 24, 23, 24, 7,
        0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        6, 0, 0, 0, 0, 0, 0, 0, 0, 7, 6, 7, 0, 0, 0, 7, 7, 6, 0, 0, 0, 0, 0, 6, 0, 0, 0, 18, 19, 16, 17, 0,
        0, 8, 11, 8, 0, 11, 9, 0, 0, 0, 0, 7, 0, 0, 7, 7, 6, 6, 0, 0, 0, 0, 0, 6, 6, 0, 0, 23, 24, 21, 22, 0,
        0, 9, 8, 11, 11, 8, 9, 11, 8, 8, 11, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 7, 0, 0, 0, 0, 7, 0, 6, 0, 0, 0, 6, 0, 0, 0, 7, 6, 7, 6, 7, 7, 7, 6, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "t_doors",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["layer"] = 1
      },
      objects = {
        {
          id = 101,
          name = "door3",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 64,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 102,
          name = "door1",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 288,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 103,
          name = "door2",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 288,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 104,
          name = "door4",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 336,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "s_colliders",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["layer"] = 1
      },
      objects = {
        {
          id = 52,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 32,
          width = 368,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 368,
          width = 496,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 256,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 256,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 57,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 256,
          width = 240,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 272,
          width = 16,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 272,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 272,
          width = 96,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 288,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 272,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 336,
          width = 48,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 352,
          width = 112,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 336,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 272,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 71,
          name = "",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 320,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 72,
          name = "",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 48,
          width = 64,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 73,
          name = "",
          type = "",
          shape = "rectangle",
          x = 464,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 80,
          width = 48,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 48,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 64,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "",
          type = "",
          shape = "rectangle",
          x = 176,
          y = 112,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 80,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 48,
          width = 16,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 81,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 160,
          width = 176,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 82,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 80,
          width = 16,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 112,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 112,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 80,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 87,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 64,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 88,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 89,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 16,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 90,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 93,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 144,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 94,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 176,
          width = 192,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 96,
          name = "",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 192,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 97,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 192,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 154,
          name = "",
          type = "",
          shape = "rectangle",
          x = 496,
          y = 208,
          width = 16,
          height = 176,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 155,
          name = "",
          type = "",
          shape = "rectangle",
          x = 496,
          y = 48,
          width = 16,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "s_spawn",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["layer"] = 1
      },
      objects = {
        {
          id = 18,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 121,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 120.241,
          y = 297.913,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 122,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 393.977,
          y = 178.532,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 123,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 288.12,
          y = 122.573,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 143,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 363.199,
          y = 317.965,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 158,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 186.46,
          y = 332.422,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 159,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 222.834,
          y = 226.564,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 160,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 278.327,
          y = 292.317,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 161,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 241.021,
          y = 328.225,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 162,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 420.558,
          y = 214.906,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 163,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 347.81,
          y = 216.771,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 164,
          name = "skeleton",
          type = "",
          shape = "rectangle",
          x = 354.339,
          y = 56.82,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
