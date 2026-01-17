world {}                         

table_base (world) { Q:[0 0 .6]  shape:marker, size:[.05]  }

table(table_base): {
 shape: ssBox, Q:[0, 0, -.05], size: [2., 4, .1, .02], color: [.3, .3, .3],
 contact: 1, logical: { is_box, is_place },
 friction: .1
}



# --- 双臂机器人加载 ---
Prefix: "l_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Prefix: "r_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False


Edit l_panda_base (table): { Q: "t(-.4 -.2 .05) d(90 0 0 1)" }
Edit r_panda_base (table): { Q: "t(+.4 -.2 .05) d(90 0 0 1)" }





### hook



stick (table_base){
  shape:ssBox size:[.8 .025 .04 .01] color:[.6 .3 0] contact, logical:{ object, pusher }
  Q: "t(0.6 0.3 0.02) d(90 0 0 1)" #  t(.5 .7 .02) 
  joint:rigid
}

stickTip (stick) { Q: "t(.4 .1 0) d(90 0 0 1)" shape:ssBox size:[.2 .026 .04 0.01] color:[.6 .3 0], logical:{ object, pusher }, contact }

stick_pusher (stickTip) { 
  shape:marker, 
  size:[.02],  # 在可视化中显示为一个小的标记点
  Q: "t(.1 0 0)" # 假设 stickTip 长 0.2，这个位置就在尖端
}

### ball 
#redBall (table) {
#  joint: free
#  shape: sphere
#  size: [.03]
#  color: [1, 0, 0]
#  mass: 0.1
#  contact: 1
#  logical: { is_object }
#  Q: [-0.4, 0.3, 0.08] 
#}

trayR (table_base) 	{  Q:[-0.3, .6, 0], shape:ssBox, size:[0.15, 0.07, 0.01, 0.005], color:[.6, 0, 0], logical:{ is_box, is_place } }

objR (table) 	{  Q:[.3, .8, .1], joint:rigid, shape:ssBox, size:[0.06, 0.06, .1, .005], color:[.7, 0, 0], contact:1, logical:{ is_object } }
