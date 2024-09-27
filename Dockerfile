FROM danysk/manjaro-with-zsh:292.20240927.0834
# Easy Game
RUN pamac install curl
RUN pamac install diffutils
RUN pamac install gradle
RUN pamac install hugo
RUN pamac install jdk-openjdk
RUN pamac install jdk21-openjdk
RUN pamac install kotlin
RUN pamac install python-matplotlib
RUN pamac install python-numpy
RUN pamac install python-xarray
RUN pamac install ruby
RUN pamac install ruby-ffi
RUN pamac install ruby-irb
RUN pamac install ruby-rdoc
RUN pamac install ruby-sass
RUN pamac install rubygems
RUN pamac install scala3
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
