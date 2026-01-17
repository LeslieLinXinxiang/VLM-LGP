#include <Kin/kin.h>
#include <Kin/viewer.h>

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    // 1. 创建 Configuration 对象
    rai::Configuration C;

    // 2. 加载我们专门用于可视化的 .g 文件
    C.addFile("final_scene.g");

    // 3. 显示场景，并一直等待，直到用户关闭窗口
    C.view(true, "Final Scene Sanity Check");

    return 0;
}
