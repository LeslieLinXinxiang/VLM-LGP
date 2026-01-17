world {}

# --- 1. 环境设置 ---
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }



# ==============================================================================
# 2. 供料区 (Storage Area)
# ==============================================================================

	
cyl1 (table) { Q:"t(-0.4 0.15 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[0 .8 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } # Green

