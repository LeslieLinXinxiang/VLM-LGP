# training_scene_1.g
# 训练场景1：一个 base 在下，两个 cyl 在上。

world {}
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.5 .5 .5], contact:1 }

# 1. 一个 base on top
base1 (table) { 
  Q:"t(0 0 .07)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0]  # Red
}


# 2. 两个 cyl 在 base 上面
cyl1 (table) { Q:"t(-0.15 -0.1 .14)", shape:cylinder, size:[.1 .04], color:[1 1 0] } # Yellow
cyl2 (table) { Q:"t(0.15 -0.1 .14)", shape:cylinder, size:[.1 .04], color:[0 1 1] } # Cyan
cyl3 (table) { Q:"t(-0.15 0.1 .14)", shape:cylinder, size:[.1 .04], color:[1 0 1] } # Yellow
cyl4 (table) { Q:"t(0.15 0.1 .14)", shape:cylinder, size:[.1 .04], color:[0 1 0] } # Green
