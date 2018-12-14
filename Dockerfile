FROM alpine

# Uncomment to use proxy for accessing internet
# RUN touch /etc/profile.d/env.sh
# RUN echo 'export http_proxy=scheme://server:port' >> /etc/profile.d/env.sh
# RUN echo 'export http_proxy=scheme://server:port' >> /etc/profile.d/env.sh
# RUN source /etc/profile.d/env.sh \
# && apk add --update nodejs-current \

# Comment to use proxy for accessing internet
RUN apk add --update nodejs-current \
&& apk add nodejs-npm \
&& set -x \
&& apk add --no-cache ca-certificates curl ffmpeg python gnupg \
    # Install youtube-dl
    # https://github.com/rg3/youtube-dl
 && curl -Lo /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
 && curl -Lo youtube-dl.sig https://yt-dl.org/downloads/latest/youtube-dl.sig \
 && chmod a+rx /usr/local/bin/youtube-dl \
    # Clean-up
 && rm youtube-dl.sig \
 && apk del curl gnupg \
    # Create directory to hold downloads.
 && mkdir /downloads \
 && chmod a+rw /downloads \
    # Basic check it works.
 && youtube-dl --version

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt



