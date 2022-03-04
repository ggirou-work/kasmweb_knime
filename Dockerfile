FROM kasmweb/core-ubuntu-bionic:1.10.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### START CUSTOMIZATION ########

# Install Knime
RUN cd /opt/ \
    && wget https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz \
    && tar xvf knime-latest-linux.gtk.x86_64.tar.gz \
    && rm -rf knime-latest-linux.gtk.x86_64.tar.gz \
    && mv /opt/knime_* /opt/knime

# Create desktop shortcuts
COPY resources/knime.desktop $HOME/Desktop/

######### END CUSTOMIZATIONS ########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
