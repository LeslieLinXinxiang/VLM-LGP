import os
import cv2
import glob

# 路径配置
TRAIN_DIR = "incontext_training/orientations"

def convert_all_to_grayscale():
    print(f">>> Converting images in {TRAIN_DIR} to GRAYSCALE...")
    
    # 获取所有png
    images = glob.glob(os.path.join(TRAIN_DIR, "*.png"))
    
    for img_path in images:
        # 读取
        img = cv2.imread(img_path)
        if img is None: continue
        
        # 转换为灰度
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        
        # 重新保存覆盖原图 (或者保存为3通道的灰度图以保持兼容性)
        # 这里的关键是：视觉上它必须没有颜色
        gray_3ch = cv2.cvtColor(gray, cv2.COLOR_GRAY2BGR)
        
        cv2.imwrite(img_path, gray_3ch)
        print(f"    Converted: {os.path.basename(img_path)}")

    print(">>> All examples are now colorless. Color bias eliminated.")

if __name__ == "__main__":
    convert_all_to_grayscale()