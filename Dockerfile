FROM danysk/manjaro-with-zsh:332.20250729.1719
USER build
RUN paru -Sy\
    archlinux-keyring\
    chaotic-keyring\
    manjaro-keyring\
    --noconfirm
RUN paru -Sy \
    curl\
    diffutils\
    gcc\
    gradle\
    hugo\
    jdk-openjdk\
    jdk21-openjdk\
    ki-shell-bin\
    kotlin\
    libxml2\
    make\
    nano\
    patch\
    python-matplotlib\
    python-numpy\
    python-xarray\
    ruby\
    ruby-ffi\
    ruby-irb\
    ruby-rdoc\
    ruby-sass\
    rubygems\
    scala\
    --noconfirm
RUN paru -Sccd --noconfirm
USER root
RUN paccache -rk 0
# System configuration
RUN archlinux-java set java-21-openjdk
RUN mkdir /rubygems
RUN chmod 777 /rubygems
ENV GEM_HOME=/rubygems/bin
ENV PATH="$GEM_HOME:$PATH"
# Broken, see https://github.com/moby/moby/issues/29110
ENV PATH="$(for ruby_bin in /root/.gem/ruby/*/bin; do ruby_path="$ruby_bin:$ruby_path"; done; echo $ruby_path)$PATH"
RUN gem install --no-user-install bundler jekyll
RUN useradd -m user
RUN passwd -d user
RUN printf 'user ALL=(ALL) ALL\n' | tee -a /etc/sudoers
WORKDIR /home/user
USER user
ENTRYPOINT [ "/bin/zsh", "-c" ]
CMD [ "zsh" ]

