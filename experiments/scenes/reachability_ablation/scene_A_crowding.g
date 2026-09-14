# full_assembly_scene.g
# Full initial assembly scene for VLM-LGP
# Objects: 8 RectPrism, 2 Cylinder, 4 Cube, 1 TriPrism
# Layout: start zone on table left side (X negative), arm front-center

world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# Robot (Panda Arm)
# -----------------------------------------------------------
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# --- Retract Pose ---
Edit l_panda_joint2 { q: -1.5 }
Edit l_panda_joint4 { q: -2.5 }
Edit l_panda_joint6 { q: 1.5 }
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint7 { q: 0.0 }
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }

# =====================================================================
# 场景 A — 拥挤(①层 几何评分拦截,安全考虑)
# 近处一对方块间距 5cm,真机上夹爪无法安全进入;远处一块孤立可安全抓取
# 传统测距法:先选最近的 cube_tight_1 -> 撞机风险
# 本文方法 :rho_clear 低 -> ①层剪除 -> 改选 cube_clear
# =====================================================================
cube_tight_1 (table) { Q:"t(0.00 0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[.85 .25 .2], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_tight_2 (table) { Q:"t(0.05 0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[.85 .25 .2], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_clear   (table) { Q:"t(-0.30 0.25 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[.2 .6 .35], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
