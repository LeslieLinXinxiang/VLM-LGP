# /home/leslie/Projects/VLM_LGP/rai/test/house_stacking/house.g (Version 2.1)

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../LGP/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } # ## CORRECTED ## 机器人向前移动，离工作区更近


trayR (table) 	{  Q:[.1, .4, 0.05], shape:ssBox, size:[0.15, 0.07, 0.01, 0.005], color:[.6, 0, 0], logical:{ is_box, is_place } }

trayG (table) 	{  Q:[.4, .1, 0], shape:ssBox, size:[0.07, 0.07, 0.01, 0.005], color:[0, .6, 0], logical:{ is_box, is_place } }

trayB (table) 	{  Q:[-.3, .3, 0], shape:ssBox, size:[0.07, 0.07, 0.01, 0.005], color:[0, 0, .6], logical:{ is_box, is_place } }
        
objR (table) 	{  Q:[-.4, .1, .1], joint:rigid, shape:ssBox, size:[0.06, 0.06, .1, .005], color:[.7, 0, 0], contact:1, logical:{ is_object } }



placeR (table) { Q: [.3 .3 .1], shape:quad, size: [.15 .15], color:[.5 .5 .5] logical:{ is_place } }
