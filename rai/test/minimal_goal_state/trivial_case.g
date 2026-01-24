# ====================================================================
# almost_done.g
# 一个最小化的诊断场景。
# 所有房屋组件，除了屋顶 (roof)，都已处于最终的目标位置。
# 唯一需要执行的任务是：将 roof 放置到 roof_target 上。
# ====================================================================

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../LGP/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# ====================================================================
# --- 房屋组件 (几乎全部就位) ---
# ====================================================================

# 1. 底座 (base_handle & base) - 已放置在目标位置 base_target
# base_target 的世界坐标 Z 是 0.6 + 0.12 = 0.72
base_handle (table) { 
  Q:"t(0 .3 .12)", # 直接使用 base_target 的坐标
  joint:rigid, shape:ssBox, size:[.04 .04 .06 .002], color:[.5 .5 .5], 
  contact:1, mass:.5, logical:{ is_object } 
}
base (base_handle) { 
  Q:"t(0 0 -.05)", shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], 
  logical:{ is_object } 
}

# 2. 四根圆柱 (cyl1-4) - 已放置在各自的目标位置 cylX_target
# cyl1_target 的世界坐标 Z 是 0.6 + 0.14 = 0.74
cyl1 (table) { 
  Q:"t(-0.15 0.2 0.14)", # 直接使用 cyl1_target 的坐标
  joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], 
  contact:1, mass:.2, logical:{ is_object, is_cylinder } 
}
cyl2 (table) { 
  Q:"t(0.15 0.2 0.14)", # 直接使用 cyl2_target 的坐标
  joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], 
  contact:1, mass:.2, logical:{ is_object, is_cylinder } 
}
cyl3 (table) { 
  Q:"t(-0.15 0.4 0.14)", # 直接使用 cyl3_target 的坐标
  joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], 
  contact:1, mass:.2, logical:{ is_object, is_cylinder} 
}
cyl4 (table) { 
  Q:"t(0.15 0.4 0.14)", # 直接使用 cyl4_target 的坐标
  joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], 
  contact:1, mass:.2, logical:{ is_object, is_cylinder} 
}

# 3. 屋顶 (roof_handle & roof) - 保持在初始位置
roof_handle (table) { 
  Q:"t(-0.5 -0.4 .12)", # 原始 house.g 中的位置
  joint:rigid, shape:ssBox, size:[.04 .04 .06 .002], color:[1 .5 0], 
  contact:1, mass:.5, logical:{ is_object, is_box } 
}
roof (roof_handle) { 
  Q:"t(0 0 -.05)", shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], 
  logical:{ is_place} 
}

# ====================================================================
# --- 虚拟目标框架 (Virtual Targets) ---
# ====================================================================
 
# 1. 定义 base_target 以便计算 roof_target 的位置
base_target (table) { 
  Q:"t(0 .3 .12) d(0 0 0 1)", 
  logical:{ is_pose } 
}  

# 2. 定义屋顶的最终目标
# roof_target 的 Z 坐标 (相对 base_target) 是 0.14
# 世界坐标 Z = 0.72 (base_target) + 0.14 = 0.86
roof_target (base_target) { 
  Q:"t(0 0 0.14) d(0 0 0 1)", 
  logical:{ is_pose } 
}
