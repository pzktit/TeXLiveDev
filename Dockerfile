FROM ghcr.io/pzktit/texliveci

LABEL Piotr ZAWADZKI "pzawadzki@polsl.pl"

USER root
WORKDIR /tmp

RUN tlmgr update --self --all
RUN wget --quiet https://github.com/valentjn/ltex-ls/releases/download/15.2.0/ltex-ls-15.2.0-linux-x64.tar.gz -P /tmp && tar xf /tmp/ltex-ls-15.2.0-linux-x64.tar.gz --strip-components=2 -C /usr --exclude={*.md,*.xml} && rm /tmp/ltex-ls*

WORKDIR /home/vscode
USER vscode

ADD --chown=vscode:vscode download-vs-code-server.sh /home/vscode
RUN chmod a+x download-vs-code-server.sh && ./download-vs-code-server.sh >/dev/null && rm -rf ./download-vs-code-server.sh && \
  .vscode-server/bin/*/bin/code-server --install-extension "james-yu.latex-workshop" && \
  .vscode-server/bin/*/bin/code-server --install-extension "valentjn.vscode-ltex" && \
  rm -rf .vscode-server/bin/ && \
  rm -rf .vscode-server/data



