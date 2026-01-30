// ============================================================================
// view_scene.cpp
// 一个简单的场景查看器。
// 功能：加载一个 .g 文件并将其可视化，然后等待用户关闭窗口。
// ============================================================================

#include <Kin/kin.h>
#include <Kin/viewer.h>

#include <iostream>

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    // 1. 检查命令行参数
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <path_to_scene.g>" << std::endl;
        return 1;
    }
    const char* scene_file = argv[1];

    std::cout << ">>> 正在加载场景文件: " << scene_file << " <<<" << std::endl;

    // 2. 创建并加载 Configuration
    rai::Configuration C;
    try {
        C.addFile(scene_file);
    } catch (const std::exception& e) {
        std::cerr << "加载 .g 文件时出错: " << e.what() << std::endl;
        return 1;
    }
    
    std::cout << ">>> 场景加载成功! <<<" << std::endl;
    std::cout << ">>> 按下 'q' 或关闭窗口以退出。 <<<" << std::endl;

    // 3. 创建 Viewer 并显示场景
    //    C.view() 会创建一个 ConfigurationViewer，更新其状态，
    //    并进入一个阻塞循环，直到用户关闭窗口或按下 'q'。
    C.view(true, scene_file);

    std::cout << ">>> 查看器已关闭。程序退出。 <<<" << std::endl;

    return 0;
}