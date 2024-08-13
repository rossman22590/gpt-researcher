# Use an official Python runtime as a parent image
FROM python:3.11.4-slim-bullseye

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    firefox-esr \
    wget \
    gcc \
    libxml2-dev \
    libxslt-dev \
    && rm -rf /var/lib/apt/lists/*

# Install geckodriver
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz \
    && tar -xvzf geckodriver* \
    && chmod +x geckodriver \
    && mv geckodriver /usr/local/bin/ \
    && rm geckodriver-v0.33.0-linux64.tar.gz

# Set up the working directory
WORKDIR /usr/src/app

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir lxml_html_clean

# Patch newspaper3k to use lxml_html_clean
RUN sed -i 's/import lxml.html.clean/import lxml_html_clean as clean/' /usr/local/lib/python3.11/site-packages/newspaper/parsers.py

# Copy the rest of the application
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# The command will be overridden by docker-compose
CMD ["python", "main.py"]
