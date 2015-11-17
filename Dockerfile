FROM haskell:7.8

RUN cabal update

# Add .cabal file
ADD ./sctty.cabal /opt/app/sctty.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
RUN cd /opt/app && cabal install --only-dependencies -j4

# Add and Install Application Code
ADD ./app /opt/app
RUN cd /opt/app && cabal install

# Add installed cabal executables to PATH
ENV PATH /root/.cabal/bin:$PATH

# Default Command for Container
WORKDIR /opt/app
CMD ["sctty"]
