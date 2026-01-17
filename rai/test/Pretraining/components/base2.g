world {}

# --- 1. 环境设置 ---
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }



# ==============================================================================
# 2. 供料区 (Storage Area)
# ==============================================================================

	
base2 (table) { Q:"t(0.5 -0.32 .065)", joint:rigid, shape:ssBox, size:[.45 .35 .03 .002], color:[.9 .1 .1], contact:1, mass:.5, logical:{ is_object, is_place } } # Red
base2_handle (base2) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.9 .1 .1], contact:1, mass:.2, logical:{ is_object } }



	
# --- Base 2 Targets ---
frontleft_base2 (base2) { Q: [0.15 0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
frontright_base2 (base2) { Q: [-0.15 0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
backleft_base2 (base2) { Q: [0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
backright_base2 (base2) { Q: [-0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

back_base2 (base2) { Q: [0 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
front_base2 (base2) { Q: [0 0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
left_base2 (base2) { Q: [0.15 0 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
right_base2 (base2) { Q: [-0.15 0 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

