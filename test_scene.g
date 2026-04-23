world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# 1. Cylinder
obj_01 (table) { Q:"t(-0.5 0 .065)", joint:rigid, shape:cylinder, size:[.03 .015], color:[0 .8 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 

# 2. Rectangular Prism
obj_03 (table) { Q:"t(-0.6 0 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .9 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place} } 

# 3. Cube
obj_05 (table) { Q:"t(-0.7 0 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 .5 0], contact:1, mass:.2, logical:{ is_object, is_box, is_place} } 

# 4. Triangular Prism
obj_07 (table) { Q:"t(-0.8 0 .06)", joint:rigid, shape:mesh, mesh:"generated/triangular_prism.obj", color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_place} } 

# Cameras explicitly for obj_07
cam_top (obj_07) { Q:"t(0 0 0.3) d(180 1 0 0)", shape:camera }
cam_front (obj_07) { Q:"t(0 0.2 0.05) d(90 1 0 0)", shape:camera }
# Work Area Base
obj_09 (table) { Q:"t(0.45 0 .06)", joint:rigid, shape:ssBox, size:[.25 .25 .02 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } } 
