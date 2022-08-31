local function sprite(name)
    return '__Trollbomb__/graphics/items/'..name
end

if not data.raw.item["trollface"] then
data:extend({
	{
	icon = "__Trollface__/graphics/icons/trollface.png",
	icon_size = 64, icon_mipmaps = 1,
	name = "trollface",
	order = "a",
	stack_size = 200,
	subgroup = "other",
	type = "item"
	}
})
end

local troll_explosion = {
    type = "explosion",
    name = "troll-explosion",
    animations =
    {
      {
        filename = "__Trollbomb__/graphics/anim/trollface.png",
        priority = "extra-high",
		size = 64,
		frame_count = 16,
		line_length = 4,
		scale = 4,
        animation_speed = 0.5
      }
    },
    light = {intensity = 1, size = 50},
    sound =
    {
      aggregation =
      {
        max_count = 1,
        remove = true
      },
      variations =
      {
        {
          filename = "__Trollbomb__/sounds/augh.ogg",
          volume = 1.0
        },
		{
		  filename = "__Trollbomb__/sounds/amogus.ogg",
		  volume = 1.0
		},
		{
		  filename = "__Trollbomb__/sounds/baby.ogg",
		  volume = 1.0
		},
		{
		  filename = "__Trollbomb__/sounds/blap.ogg",
		  volume = 1.0
		},
		{
		  filename = "__Trollbomb__/sounds/burenya.ogg",
		  volume = 1.0
		},
        {
          filename = "__Trollbomb__/sounds/fart.ogg",
          volume = 1.0
        },
        {
          filename = "__Trollbomb__/sounds/notification.ogg",
          volume = 1.0
        },
        {
          filename = "__Trollbomb__/sounds/saul.ogg",
          volume = 1.0
        }
      }
    }
  }


local troll_grenade = table.deepcopy(data.raw['projectile']['grenade'])

troll_grenade.name = 'troll-grenade'

troll_grenade.animation = {
	filename = sprite('trollface.png'),
	size = {64,64},
	scale = 0.54,
	line_length = 1,
	frame_count = 1,
	shift = {0,-0}
}

troll_grenade.action = {
  {
    type = 'direct',
    action_delivery = {
      type = 'instant',
      target_effects = {
        {
          type = 'create-entity',
          entity_name = 'troll-explosion',
          trigger_created_entity = true
        }
      }
    }
  },
  {
    type = 'area',
    radius = 7.5,
    force = 'not-same',
    action_delivery = {
      {
        type = 'instant',
        target_effects = {
          {
            type = 'damage',
            damage = {
              amount = 0,
              type = 'explosion'
            }
          },
          {
            type = 'create-sticker',
            sticker = 'stun-sticker'
          },
          {
            type = "push-back",
            distance = 500
          }
        }
      }
    }
  }
}

local troll_capsule = table.deepcopy(data.raw['capsule']['grenade'])
troll_capsule.name = 'troll_grenade'
troll_capsule.icon_size = 64
troll_capsule.icon = sprite("trollface.png")

troll_capsule.capsule_action.attack_parameters.ammo_type.action[1] = {
    type = "direct",
    action_delivery =
    {
      type = "projectile",
      projectile = "troll-grenade",
      starting_speed = 0.3
    }
}

data:extend{troll_explosion, troll_grenade, troll_capsule}