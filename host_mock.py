# host_mock.py (Run this on Host)
import zmq
import json
import time

PORT = 5555

def start_mock_server():
    context = zmq.Context()
    socket = context.socket(zmq.REP)
    socket.bind(f"tcp://*:{PORT}")
    
    print(f"[Mock-Robot] 🤖 ONLINE. Listening on port {PORT}...")
    print(f"[Mock-Robot] Waiting for Docker brain commands...\n")

    while True:
        try:
            # 1. 接收消息
            message = socket.recv_json()
            cmd_type = message.get("type")
            payload = message.get("payload")
            timestamp = message.get("timestamp")

            # 2. 打印接收到的数据 (验证通信是否成功)
            print(f"📨 [RECV] Type: {cmd_type} | Time: {timestamp}")
            
            if cmd_type == "EXECUTE_TRAJ":
                traj = payload.get("trajectory", [])
                print(f"   >> ⚠️ TRAJECTORY DATA: Received {len(traj)} waypoints.")
                if len(traj) > 0:
                    print(f"   >> Start: {traj[0]}")
                    print(f"   >> End  : {traj[-1]}")
                # 模拟机器人运动耗时
                time.sleep(0.5) 
                
            elif cmd_type == "MOVE_GRIPPER":
                width = payload.get("width", 0.0)
                print(f"   >> 🤏 GRIPPER COMMAND: Width = {width}")
                time.sleep(0.1)

            # 3. 发送回执 (ACK)
            socket.send_json({"status": "success", "info": "Mock execution done"})
            print("   ✅ [ACK] Sent success signal.\n")

        except KeyboardInterrupt:
            print("\n[Mock-Robot] Shutting down.")
            break
        except Exception as e:
            print(f"❌ Error: {e}")
            # 即使出错也要发送回执，防止 Docker 卡死
            socket.send_json({"status": "error", "info": str(e)})

if __name__ == "__main__":
    start_mock_server()