#    Copyright (c) 2020 Cisco and/or its affiliates.
#    This software is licensed to you under the terms of the Cisco Sample
#    Code License, Version 1.1 (the "License"). You may obtain a copy of the
#    License at
#                   https://developer.cisco.com/docs/licenses
#    All use of the material herein must be in accordance with the terms of
#    the License. All rights not expressly granted by pytthe License are
#    reserved. Unless required by applicable law or agreed to separately in
#    writing, software distributed under the License is distributed on an "AS
#    IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
#    or implied.

FROM multiarch/qemu-user-static as qemu
FROM arm64v8/alpine:3.7
COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin
# FROM python:3.8.2
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk upgrade --available
RUN apk add --no-cache python3 && \
    pip3 install --upgrade pip setuptools

RUN mkdir /app
WORKDIR /app
ADD . /app/
RUN pip3 install -r /app/requirements.txt

#EXPOSE 5001
CMD ["python3", "/app/app.py"]
