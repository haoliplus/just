# change ubuntu to your os
docker run -it --rm  -v /:/hostOS ubuntu:20.04 chroot /hostOS /bin/sh

# usermod -aG sudo demo
