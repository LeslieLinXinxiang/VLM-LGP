// ============================================================================
// main.cpp (Camera Tuner - Fixed API Version)
// ============================================================================

#include <Kin/kin.h>
#include <Gui/opengl.h>
#include <iostream>
#include <iomanip>

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <path_to_scene.g>" << std::endl;
        return 1;
    }
    const char* scene_file = argv[1];

    rai::Configuration C;
    try {
        C.addFile(scene_file);
    } catch (const std::exception& e) {
        std::cerr << "加载错误: " << e.what() << std::endl;
        return 1;
    }

    std::cout << "========================================================" << std::endl;
    std::cout << "   相机调参工具 (Camera Tuner)" << std::endl;
    std::cout << "   1. 鼠标 [左键] 旋转 / [右键] 平移 / [滚轮] 缩放" << std::endl;
    std::cout << "   2. 调整好后，抄写下方的 Pos 和 Quat" << std::endl;
    std::cout << "   3. 按 'q' 退出" << std::endl;
    std::cout << "========================================================" << std::endl;

    while(true) {
        // 1. 使用 Configuration 自带的视图管理器
        // view(false) 是非阻塞模式，每次调用刷新一次窗口
        int key = C.view(false, "Camera Tuner - Press 'q' to exit");

        // 2. 检查退出
        if(key == 'q' || key == 27) break;

        // 3. 访问底层 OpenGL 相机
        // 【关键修正】C.gl() 返回的是引用，直接用 . 访问
        try {
            rai::Camera& cam = C.gl().camera;

            // 获取参数
            arr pos = cam.X.pos.getArr();
            arr quat = cam.X.rot.getArr();
            double focal = cam.focalLength;

            // 实时打印
            std::cout << std::fixed << std::setprecision(3)
                      << "\r"
                      << "Pos:{" << pos(0) << "," << pos(1) << "," << pos(2) << "} "
                      << "Quat:{" << quat(0) << "," << quat(1) << "," << quat(2) << "," << quat(3) << "} "
                      << "Focal:" << focal << "    "
                      << std::flush;
        } catch(...) {
            // 防止窗口初始化瞬间的访问异常
        }

        // 降低刷新率
        rai::wait(0.1);
    }

    std::cout << "\n\n>>> 退出。" << std::endl;
    return 0;
}
