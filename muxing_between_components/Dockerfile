FROM python:3.12-slim

WORKDIR /workdir
COPY . .
RUN pip install ./python_package_a ./python_package_b

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh" ]