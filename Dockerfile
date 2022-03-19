# Builds a considerably smaller image

FROM python:3.10-slim

# # set work directory

# COPY ./app /app

# set env variables

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8008
ENV PATH="$PATH:$HOME/.poetry/bin"


WORKDIR /app

# We install poetry

RUN pip3 install poetry

# We install dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root --no-dev

# We copy project
COPY . .
RUN poetry install --no-dev


EXPOSE 8008


# We command it to run on the container and start
CMD ["poetry run", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8008"]