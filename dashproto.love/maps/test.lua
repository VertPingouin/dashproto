return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 26,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "spawn",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "trigger",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 23,
          name = "room1",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 864,
          height = 544,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "trigger1",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 288,
          width = 64,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "colliders",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 160,
          width = 288,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 0,
          width = 288,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 0,
          width = 128,
          height = 544,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 384,
          width = 736,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 64,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 0,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 384,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 32,
          width = 32,
          height = 352,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
