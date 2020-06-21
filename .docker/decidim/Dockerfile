FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ARG TZ

RUN apt-get update
RUN apt-get install -y \
        autoconf \
        bison \
        build-essential \
        curl \
        git \
        libpq-dev \
        libssl-dev \
        libyaml-dev \
        libreadline-dev \
        zlib1g-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm-dev \
        libicu-dev \
        tzdata \
        && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
        && dpkg-reconfigure --frontend noninteractive tzdata

ARG RUBY_VERSION
ARG BUNDLER_VERSION

RUN echo "Installing rbenv" && \
    git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv && \
    echo "export PATH=\"$HOME/.rbenv/bin:\$PATH\"" >> $HOME/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc && \
    mkdir -p $HOME/.rbenv/plugins && \
    git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build && \
    export PATH="$HOME/.rbenv/bin:$PATH" && \
    eval "$(rbenv init -)" && \
    rbenv install ${RUBY_VERSION} && \
    rbenv global ${RUBY_VERSION} && \
    echo "gem: --no-document" > $HOME/.gemrc && \
    echo "Installing Decidim" && \
    gem install bootsnap && \
    gem install listen && \
    gem install decidim && \
    gem install tzinfo-data && \
    gem i bundler -v ${BUNDLER_VERSION}

ENV NVM_DIR=/opt/nvm
RUN git clone https://github.com/nvm-sh/nvm.git $NVM_DIR && \
    cd $NVM_DIR && \
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` && \
    . $NVM_DIR/nvm.sh && \
    nvm install 13 && \
    nvm use node && \
    echo "source ${NVM_DIR}/nvm.sh" >> $HOME/.bashrc

WORKDIR /decidim

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]
