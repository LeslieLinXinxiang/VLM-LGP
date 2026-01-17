world {}

# --- 1. 环境设置 ---
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }



# ==============================================================================
# 2. 供料区 (Storage Area)
# ==============================================================================

	
base1 (table) { Q:"t(0.5 0.06 .065)", joint:rigid, shape:ssBox, size:[.45 .35 .03 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } } # Grey
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.8 .8 .8], contact:1, mass:.2, logical:{ is_object } } 


	
# --- Base 1 Targets ---

frontleft_base1 (base1) { Q: [0.15 0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
frontright_base1 (base1) { Q: [-0.15 0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
backleft_base1 (base1) { Q: [0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
backright_base1 (base1) { Q: [-0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

back_base1 (base1) { Q: [0 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
front_base1 (base1) { Q: [0 0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
left_base1 (base1) { Q: [0.15 0 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
right_base1 (base1) { Q: [-0.15 0 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

