# /home/leslie/Projects/VLM_LGP/rai/test/house_stacking/final_scene.g

world {}

# --- 桌子和机器人 (保持不变) ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }
Prefix: "l_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 0 .05) d(90 0 0 1)" }

# --- 【【【【【【 核心：直接定义最终状态的房屋 】】】】】】 ---

# 1. 底座 (直接放置在最终位置)
# 我们直接使用你提供的 base_target 的 Q 值
base (table) { 
    Q:"t(0 .5 .07) d(0 0 0 1)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1 
}
base_handle (base) { Q:"t(0 0 .02)", shape:ssBox, size:[.04 .04 .06 .002], color:[.5 .5 .5] }

# 2. 四根圆柱 (直接放置在相对于底座的最终位置)
# 我们直接使用你提供的 cylX_target 的 Q 值
cyl1 (base) { Q:"t(-0.15 -0.1 0.12) d(0 0 0 1)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1 }
cyl2 (base) { Q:"t(0.15 -0.1 0.12) d(0 0 0 1)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1 }
cyl3 (base) { Q:"t(-0.15 0.1 0.12) d(0 0 0 1)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1 }
cyl4 (base) { Q:"t(0.15 0.1 0.12) d(0 0 0 1)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1 }

# 3. 屋顶 (直接放置在相对于底座的最终位置)
# 我们直接使用你提供的 roof_target 的 Q 值
roof (base) { 
    Q:"t(-.025 -.025 .24) d(0 0 0 1)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1 
}
roof_handle (roof) { Q:"t(0 0 .02)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 .5 0] }
