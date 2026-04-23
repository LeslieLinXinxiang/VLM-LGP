import yaml

with open('rai/test/newLGP/rai-robotModels/panda/panda_arm_hand_conv.yml', 'r') as f:
    data = yaml.safe_load(f)

for k, v in data.items():
    if 'pose' in v:
        print(f"RAI {k:25s} pose={v['pose']}")
