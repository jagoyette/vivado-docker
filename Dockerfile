FROM ubuntu:16.04

#RUN apt-get update && apt-get install -y \
#    git \
#    python python3 \
#    build-essential 


COPY install_config.txt /tmp/
COPY Xilinx_Vivado_SDK_Web_2019.1_0524_1430_Lin64.bin /tmp/
COPY wi_authentication_key /root/.Xilinx/

RUN /tmp/Xilinx_Vivado_SDK_Web_2019.1_0524_1430_Lin64.bin --keep --noexec --target /tmp/webinstall && \
    cd /tmp/webinstall && \
    ./xsetup -b Install -a XilinxEULA,3rdPartyEULA,WebTalkTerms -c /tmp/install_config.txt && \
    rm -rf /tmp/*





