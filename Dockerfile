FROM danysk/docker-manjaro-with-zsh:139.20230319.0935
# Easy Game
RUN yay-install curl
RUN yay-install diffutils
RUN yay-install gradle
RUN yay-install hugo
RUN yay-install jdk-openjdk
RUN yay-install jdk17-openjdk
RUN yay-install kotlin
RUN yay-install python-matplotlib
RUN yay-install python-numpy
RUN yay-install python-xarray
RUN yay-install ruby
RUN yay-install ruby-ffi
RUN yay-install ruby-irb
RUN yay-install ruby-rdoc
RUN yay-install ruby-sass
RUN yay-install rubygems
RUN yay-install scala
# System configuration
RUN archlinux-java set java-17-openjdk
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
