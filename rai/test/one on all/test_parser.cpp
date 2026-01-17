#include <Core/graph.h>
#include <iostream>
#include <sstream> // <<< 修正：添加此头文件

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);
    
    // 这是我们根据源码分析得出的唯一可能正确的语法
    const char* correct_syntax = "terminal: \"(stablePlace cyl1 cyl2 cyl3 base2)\"";

    std::cout << ">>> 正在测试语法: " << correct_syntax << std::endl;
    try {
        rai::String str = correct_syntax;
        std::stringstream ss;
        ss << str;
        
        rai::Graph G(ss); // 直接在构造函数中解析
        
        std::cout << "    [解析成功!]" << std::endl;
        
        rai::Node* n = G.getNode("terminal");
        if(n) {
            std::cout << "    节点 '" << n->key << "' 已找到。" << std::endl;
            if(n->is<rai::String>()) {
                rai::String& value = n->as<rai::String>();
                std::cout << "    节点的值 (类型 rai::String): " << value << std::endl;
            } else {
                std::cout << "    错误: 节点的值不是 rai::String 类型!" << std::endl;
            }
        } else {
            std::cout << "    错误: 找不到节点 'terminal'!" << std::endl;
        }
        
    } catch (const std::exception& e) {
        std::cout << "    [解析失败] 错误: " << e.what() << std::endl;
    } catch (...) {
        std::cout << "    [解析崩溃] 未知错误 (可能是 CHECK 失败)" << std::endl;
    }

    return 0;
}
