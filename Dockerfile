FROM phenoscape/owlery

MAINTAINER Robbie - Virtual Fly Brain <rcourt@ed.ac.uk>

# from compose args
ARG CONF_REPO
ARG CONF_BRANCH

ENV CONF_BASE=/opt/conf_base
ENV CONF_DIR=${CONF_BASE}/config/owlery

USER root

RUN apt-get -qq update || apt-get -qq update && apt-get -qq -y install git

RUN mkdir $CONF_BASE

###### REMOTE CONFIG ######
ARG CONF_BASE_TEMP=${CONF_BASE}/temp
RUN mkdir $CONF_BASE_TEMP
RUN cd "${CONF_BASE_TEMP}" && git clone --quiet ${CONF_REPO} && cd $(ls -d */|head -n 1) && git checkout ${CONF_BRANCH}
# copy inner project folder from temp to conf base
RUN cd "${CONF_BASE_TEMP}" && cd $(ls -d */|head -n 1) && cp -R . $CONF_BASE && cd $CONF_BASE && rm -r ${CONF_BASE_TEMP}

#COPY application.conf /srv/conf/application.conf

COPY startup.sh /startup.sh

RUN chmod +x /startup.sh

USER $APP_USER

ENTRYPOINT ["/startup.sh"]
