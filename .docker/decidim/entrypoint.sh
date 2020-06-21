#!/bin/bash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
. $NVM_DIR/nvm.sh
if [ ! -d "app" ]; then
    whereis bundle
    echo "Installing Decidim"
    $HOME/.rbenv/shims/decidim app
    echo 'group :production do' >> app/Gemfile
    echo '    gem "passenger"' >> app/Gemfile
    echo '    gem ''delayed_job_active_record''' >> app/Gemfile
    echo '    gem "daemons"' >> app/Gemfile
    echo 'end' >> app/Gemfile
    echo 'gem "figaro"' >> app/Gemfile
    cd /decidim/app
    whereis bundle
    bundle install
    bundle exec figaro install
    bin/rails db:create db:migrate
    cd -
fi
cd /decidim/app
bin/rails s