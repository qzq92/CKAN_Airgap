# See CKAN docs on installation from Docker Compose on usage
FROM debian:jessie
MAINTAINER Open Knowledge

# Install required system packages
RUN apt-get -q -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade \
    && apt-get -q -y install \
        apt-utils \
        python-dev \
        python-pip \
        python-virtualenv \
        python-wheel \
        libpq-dev \
        libxml2-dev \
        libxslt-dev \
        libgeos-dev \
        libssl-dev \
        libffi-dev \
        postgresql-client \
        build-essential \
        git-core \
        vim \
        wget \
        libsasl2-dev \
        python-dev \
        libldap2-dev \
        libssl-dev \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

# Define environment variables
ENV CKAN_HOME /usr/lib/ckan
ENV CKAN_VENV $CKAN_HOME/venv
ENV CKAN_CONFIG /etc/ckan
ENV CKAN_STORAGE_PATH=/var/lib/ckan
#Activate virtualenv
ENV VIRUAL_ENV $CKAN_VENV
ENV PATH $CKAN_VENV/bin:$PATH

# Build-time variables specified by docker-compose.yml / .env
ARG CKAN_SITE_URL

# Create ckan user with ckan home directory created commented with "ckan account" and default home directory as /usr/lib/ckan. User login shell is name as /bin/false ckan
RUN useradd -r -u 900 -m -c "ckan account" -d $CKAN_HOME -s /bin/false ckan

# Setup virtual environment for CKAN
RUN mkdir -p $CKAN_VENV $CKAN_CONFIG $CKAN_STORAGE_PATH && \
    virtualenv $CKAN_VENV && \
    ln -s $CKAN_VENV/bin/pip /usr/local/bin/ckan-pip &&\
    ln -s $CKAN_VENV/bin/paster /usr/local/bin/ckan-paster

# Setup CKAN
ADD . $CKAN_VENV/src/ckan/ 


#Clone geoview,viewhelpers, dashboard, basiccharts, gallery,download all,multiedit,ckanext-file_uploader_ui,ckanext-oauth2,python-ldap,officeviewer(need inet connection) :Note -e in pip install is editable mode.
RUN cd $CKAN_VENV/src/ && \
    git clone https://github.com/ckan/ckanext-geoview.git && cd ckanext-geoview && ckan-pip install -r pip-requirements.txt && \
    python setup.py install && python setup.py develop && cd .. && \
    git clone https://github.com/ckan/ckanext-viewhelpers && cd ckanext-viewhelpers && python setup.py install  && cd  .. && \
    git clone https://github.com/ckan/ckanext-dashboard && cd ckanext-dashboard && python setup.py install  && cd .. && \
    git clone https://github.com/localidata/ckanext-basiccharts && cd ckanext-basiccharts && python setup.py install  && cd .. && \
    git clone https://github.com/NaturalHistoryMuseum/ckanext-gallery.git && cd ckanext-gallery && pip install -r requirements.txt && python setup.py develop && cd .. && \
    pip install ckanext-downloadall && pip install ckanext-file_uploader_ui && \
    pip install -e git+https://github.com/Helsingin-kaupungin-tietokeskus/ckanext-multiedit.git#egg=ckanext-multiedit && \ 
    git clone https://github.com/NaturalHistoryMuseum/ckanext-ldap.git && cd ckanext-ldap && pip install -r requirements.txt && python setup.py develop && cd .. && \
    pip install ckanext-oauth2 && \ 
    pip install ckanext-pdfview && \
    ckan-pip install -e "git+https://github.com/ckan/ckanext-showcase.git#egg=ckanext-showcase" && \
    ckan-pip install ckanext-envvars && \
    ckan-pip install -U pip && \
    ckan-pip install --upgrade --no-cache-dir -r $CKAN_VENV/src/ckan/requirement-setuptools.txt && \
    ckan-pip install --upgrade --no-cache-dir -r $CKAN_VENV/src/ckan/requirements.txt && \
    ckan-pip install -e $CKAN_VENV/src/ckan/ && \
    ln -s $CKAN_VENV/src/ckan/ckan/config/who.ini $CKAN_CONFIG/who.ini && \
    cp -v $CKAN_VENV/src/ckan/contrib/docker/ckan-entrypoint.sh /ckan-entrypoint.sh && \
    chmod +x /ckan-entrypoint.sh && \
    chown -R ckan:ckan $CKAN_HOME $CKAN_VENV $CKAN_CONFIG $CKAN_STORAGE_PATH

ENTRYPOINT ["/ckan-entrypoint.sh"]

#USER ckan
EXPOSE 5000

CMD ["ckan-paster","serve","/etc/ckan/production.ini"]
