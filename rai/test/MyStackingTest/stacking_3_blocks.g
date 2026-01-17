world {}

# --- 桌子定义 ---
table_base (world) { Q:[0 0 .6]  shape:marker, size:[.05]  }

table(table_base): {
 shape: ssBox, Q:[0, 0, -.05], size: [2., 4, .1, .02], color: [.3, .3, .3],
 contact: 1, logical: { is_box, is_place }, # 桌子是基本的放置点
 friction: .1
}

# --- 双臂机器人加载 ---
Prefix: "l_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False


Edit l_panda_base (table): { Q: "t(0 0 .05) d(90 0 0 1)" }


# --- 五色方块定义 ---
# 关键点1: 尺寸缩小为 6cm 正方体，避免堆叠过高导致运动学无解
# 关键点2: logical 必须包含 is_place，这样它们才能作为其他方块的支撑面

# 红色方块 (Red)
objR (table) {
    Q:[.3, .1, .08], joint:rigid, shape:ssBox, size:[0.06, 0.06, .06, .002],
    color:[1, 0, 0], contact:1, mass: 0.1,
    logical:{ is_object, is_place } 
}

# 黄色方块 (Yellow)
objY (table) {
    Q:[.3, .3, .08], joint:rigid, shape:ssBox, size:[0.06, 0.06, .06, .002],
    color:[1, 1, 0], contact:1, mass: 0.1,
    logical:{ is_object, is_place }
}

# 蓝色方块 (Blue)
objB (table) {
    Q:[-.3, .1, .08], joint:rigid, shape:ssBox, size:[0.06, 0.06, .06, .002],
    color:[0, 0, 1], contact:1, mass: 0.1,
    logical:{ is_object, is_place }
}

# 绿色方块 (Green)
objG (table) {
    Q:[-.3, .3, .08], joint:rigid, shape:ssBox, size:[0.06, 0.06, .06, .002],
    color:[0, 1, 0], contact:1, mass: 0.1,
    logical:{ is_object, is_place }
}

# 白色方块 (White) - 作为最底层的基座
objW (table) {
    Q:[0, .5, .08], joint:rigid, shape:ssBox, size:[0.06, 0.06, .06, .002],
    color:[1, 1, 1], contact:1, mass: 0.1,
    logical:{ is_object, is_place }
}

################################################################

objW_target (table) { 
    Q:"t(0 .6 .08) d(0 0 0 1)", 
    logical:{ is_pose } 
}

# 2. 在 objW_target 的正上方，为绿色方块 (objG) 定义一个目标位置
# Z 偏移量 = objW 全高(0.06) = 0.06
# 我们让它在 X 轴上稍微偏移一点，形成一个错位的堆叠
objG_target (table) { 
    Q:"t(0 0.6 0.14) d(0 0 0 1)", 
    logical:{ is_pose } 
}

objB_target (table) { 
    Q:"t(0 0.6 0.20) d(0 0 0 1)", 
    logical:{ is_pose } 
}


