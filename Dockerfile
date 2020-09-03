FROM danysk/manjaro-with-zsh
# Easy Game
RUN yay-install curl
RUN yay-install diff
RUN yay-install gradle
RUN yay-install hugo
RUN yay-install jdk-openj9-bin
RUN yay-install jdk-openjdk
RUN yay-install jdk11-openjdk
RUN yay-install jdk8-openjdk
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
RUN archlinux-java set java-11-openjdk
ENV PATH="$(for ruby_bin in /root/.gem/ruby/*/bin; do ruby_path="$ruby_bin:$ruby_path"; done; echo $ruby_path)$PATH"
RUN gem install bundler jekyll travis
CMD zsh
