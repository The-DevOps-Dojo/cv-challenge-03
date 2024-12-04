# Use an official Python runtime as a parent image
FROM python:3.10

RUN set -xe

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - --git https://github.com/python-poetry/poetry.git@master

ENV PATH="/root/.local/bin:$PATH"

RUN poetry --version
# RUN poetry new foobar

# Set up the working directory
WORKDIR /app

# Copy and install dependencies
COPY . /app

RUN poetry install

EXPOSE 8000

# Start the application
CMD ["bash", "-c", "poetry run bash ./prestart.sh && poetry run uvicorn app.main:app --reload --host 0.0.0.0"]