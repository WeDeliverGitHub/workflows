# this args used to determine if we need to use test-packages or release-packages
ARG use_test_requirements=false

FROM python:3.7-buster
WORKDIR /app

RUN mkdir -p /app
COPY . /app

RUN pip install -r requirements.txt

RUN if [ "$use_test_requirements" = "true" ]; then \
    pip install -i https://test.pypi.org/simple/ -r requirements-test.txt; \
else \
    pip install -r requirements-release.txt; \
fi

RUN chown -R www-data:www-data /app
RUN chmod +x /app/start-server.sh

EXPOSE 8000
CMD ["/app/start-server.sh"]
