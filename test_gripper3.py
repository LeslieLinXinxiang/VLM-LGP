import robotic as ry

C = ry.Config()
C.addFile('generated/scene_named.g')

for frame in C.getFrames():
    name = frame.name
    if 'panda' in name and ('tcp' in name or 'grip' in name or 'hand' in name or 'fing' in name):
        print(f'{name:30s}: pos={frame.getPosition()}')
