FROM danysk/manjaro-with-zsh:292.20240927.1459
# Easy Game
RUN pamac install --no-confirm curl
RUN pamac install --no-confirm diffutils
RUN pamac install --no-confirm gradle
RUN pamac install --no-confirm hugo
RUN pamac install --no-confirm jdk-openjdk
RUN pamac install --no-confirm jdk21-openjdk
RUN pamac install --no-confirm kotlin
RUN pamac install --no-confirm python-matplotlib
RUN pamac install --no-confirm python-numpy
RUN pamac install --no-confirm python-xarray
RUN pamac install --no-confirm ruby
RUN pamac install --no-confirm ruby-ffi
RUN pamac install --no-confirm ruby-irb
RUN pamac install --no-confirm ruby-rdoc
RUN pamac install --no-confirm ruby-sass
RUN pamac install --no-confirm rubygems
RUN pamac install --no-confirm scala
# System configuration
RUN archlinux-java set java-21-openjdk
RUN mkdir /rubygems
RUN chmod 777 /rubygems
ENV GEM_HOME=/rubygems/bin
ENV PATH="$GEM_HOME:$PATH"
# Broken, see https://github.com/moby/moby/issues/29110
# ENV PATH="$(for ruby_bin in /root/.gem/ruby/*/bin; do ruby_path="$ruby_bin:$ruby_path"; done; echo $ruby_path)$PATH"
RUN gem install --no-user-install bundler jekyll travis
CMD useradd user\
 && passwd -d user\
 && printf 'user ALL=(ALL) ALL\n' | tee -a /etc/sudoers\
 && cp -r /etc/skel/. /home/user\
 && chown user /home/user\
 && cd /home/user/\
 && sudo -u user zsh
