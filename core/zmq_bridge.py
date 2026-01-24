import zmq
import time
import json

# Docker 内部访问宿主机，如果是 --net=host，localhost 即可
# 如果不是 host 网络，可能需要 host.docker.internal
HOST_ADDRESS = "tcp://localhost:5555"

class ExecutionManager:
    def __init__(self):
        self.context = zmq.Context()
        self.socket = self.context.socket(zmq.REQ)
        self.socket.connect(HOST_ADDRESS)
        print(f"[ZMQ-Client] Connected to {HOST_ADDRESS}")

    def home_robot(self):
        return self._send("HOME_ROBOT", {})

    def move_gripper(self, width):
        return self._send("MOVE_GRIPPER", {"width": width})

    def execute_trajectory(self, waypoints):
        # waypoints: list of list [q0, q1, ...]
        return self._send("EXECUTE_TRAJ", {"trajectory": waypoints})

    def _send(self, type_str, payload):
        msg = {
            "type": type_str,
            "timestamp": time.time(),
            "payload": payload
        }
        self.socket.send_json(msg)
        reply = self.socket.recv_json()
        return reply.get("status") == "success"
