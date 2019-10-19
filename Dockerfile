FROM ubuntu:16.04 as base

COPY install_config.txt /tmp/
COPY Xilinx_Vivado_SDK_Web_2019.1_0524_1430_Lin64.bin /tmp/
COPY wi_authentication_key /root/.Xilinx/

RUN /tmp/Xilinx_Vivado_SDK_Web_2019.1_0524_1430_Lin64.bin --keep --noexec --target /tmp/webinstall && \
    cd /tmp/webinstall && \
    ./xsetup -b Install -a XilinxEULA,3rdPartyEULA,WebTalkTerms -c /tmp/install_config.txt


# Now build an image with the installed tools and configure environment
FROM ubuntu:16.04

COPY --from=base /tools/Xilinx /tools/Xilinx

RUN apt-get update && apt-get install -y \
    git \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a user
RUN adduser --disabled-password --gecos '' vivado
USER vivado
WORKDIR /home/vivado

# Add vivado tools to path
RUN echo "source /tools/Xilinx/Vivado/2019.1/settings64.sh" >> /home/vivado/.bashrc && \
    mkdir /home/vivado/.Xilinx

