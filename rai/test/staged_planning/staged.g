# /home/leslie/Projects/VLM_LGP/rai/test/staged_planning/staged.g (Integrated Version)

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }
Prefix: "l_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# --- 初始物体定义 ---

# 1. 底座 (使用你提供的初始位置)
base (table) { Q:"t(-.5 -0.6 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:1, logical:{ is_object, is_place } }
base_handle (base) { Q:"t(0.25 0.2 0.02)", shape:ssBox, size:[.04 .04 .06 .002], color:[.5 .5 .5], logical:{ is_object, is_handle_for base } }

# 2. 四个圆柱 (需要重新定义它们的初始位置)
cyl1 (table) { Q:"t(0.2 0.0 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } }
cyl2 (table) { Q:"t(0.3 0.0 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } }
cyl3 (table) { Q:"t(0.4 0.0 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } }
cyl4 (table) { Q:"t(0.5 0.0 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } }


# --- 【【【【【【 核心：你提供的、精确的虚拟目标框架定义 】】】】】】 ---

# 1. 底座的最终放置位置 (来自你的代码)
base_target (table) { Q:"t(0 .2 .07) d(0 0 0 1)", logical:{ is_pose, is_place } }

# 2. 在“底座最终位置”上定义四个柱子的目标 (来自你的代码, 父物体修正为 base_target)
cyl1_target (base_target) { Q:"t(-0.15 -0.1 0.12) d(0 0 0 1)", logical:{ is_pose, is_place } }
cyl2_target (base_target) { Q:"t(0.15 -0.1 0.12) d(0 0 0 1)", logical:{ is_pose, is_place } }
cyl3_target (base_target) { Q:"t(-0.15 0.1 0.12) d(0 0 0 1)", logical:{ is_pose, is_place } }
cyl4_target (base_target) { Q:"t(0.15 0.1 0.12) d(0 0 0 1)", logical:{ is_pose, is_place } }
