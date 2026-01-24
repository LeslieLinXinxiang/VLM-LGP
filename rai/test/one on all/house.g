# /home/leslie/Projects/VLM_LGP/rai/test/house_stacking/house.g (Version 2.1)

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../LGP/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } # ## CORRECTED ## 机器人向前移动，离工作区更近


trayR (table) 	{  Q:[.1, .4, 0.05], shape:ssBox, size:[0.15, 0.07, 0.01, 0.005], color:[.6, 0, 0], logical:{ is_box, is_place } }


        
objR (table) 	{  Q:[-.4, .4, .1], joint:rigid, shape:ssBox, size:[0.06, 0.06, .1, .005], color:[.7, 0, 0], contact:1, logical:{ is_object } }



placeR (table) { Q: [0 0.5 .05], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }


cyl1 (table) { Q:"t(-0.4 0 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl2 (table) { Q:"t(-0.5 0 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl3 (table) { Q:"t(-0.4 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl4 (table) { Q:"t(-0.5 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }


base1 (table) { Q:"t(0 0 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object , is_place} }
