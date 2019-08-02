FROM ubuntu

RUN apt-get update
RUN apt-get install -y protobuf-compiler python-pil python-lxml python-pip python-dev git curl && rm -rf /var/lib/apt/lists/*
RUN pip install Flask==0.12.2 WTForms==2.1 Flask_WTF==0.14.2 Werkzeug==0.12.2

RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.1.0-cp27-none-linux_x86_64.whl

RUN cd $HOME

COPY ./build.sh .

RUN ./build.sh

RUN cd $HOME && git clone https://github.com/GoogleCloudPlatform/tensorflow-object-detection-example && cp -a tensorflow-object-detection-example/object_detection_app /opt/

EXPOSE 80

CMD python /opt/object_detection_app/app.py
