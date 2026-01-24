world {}                         

table_base (world) { Q:[0 0 .6]  shape:marker, size:[.05]  }

table(table_base): {
 shape: ssBox, Q:[0, 0, -.05], size: [2., 1.5, .1, .02], color: [.3, .3, .3],
 contact: 1, logical: { is_box, is_place },
 friction: .1
}

Prefix: "l_"
Include: <../LGP/newLGP/rai-robotModels/panda/panda.g>
Prefix: False


Edit l_panda_base (table): { Q: "t(.0 .0 .05) d(90 0 0 1)" }

# 长方形物块
rect_obj (table) {
    Q:[0, .5, .08], joint:rigid, shape:ssBox, size:[.2, .06, .06, .002], # 长 20cm, 宽 6cm, 高 6cm
    color:[0, 1, 0], contact:1, mass: 0.1,
    logical:{ is_object, is_place }
}

# 正方形物块
square_obj (table) {
    Q:[.3, .5, .08], joint:rigid, shape:ssBox, size:[.06, .06, .06, .002], # 6cm 立方体
    color:[1, 0, 0], contact:1, mass: 0.1,
    logical:{ is_object,} # 假设我们只移动它
}

# 在长方形上定义一个虚拟的目标位姿
# 它的位置在 rect_obj 的 Z 轴正方向 (高度差)，并在 X 轴负方向 (左边)
# Q:[x, y, z]
# x = - (长方形半长 - 正方形半长) = - (0.1 - 0.03) = -0.07
# y = 0 (Y轴对齐)
# z = (长方形半高 + 正方形半高) = (0.03 + 0.03) = 0.06
square_target_pose (rect_obj) {
    Q:[-0.07, 0, 0.06],
    logical: { is_pose } # 【【【 关键中的关键！赋予它 is_pose 属性 】】】
}


