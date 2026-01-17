# 建议保存为 start_sim.sh
docker run -it --name vlm_sim \
  --net=host \
  --gpus all \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$HOME/Projects/VLM_LGP":/root/vlm_project \
  vlm-ros-humble-ready