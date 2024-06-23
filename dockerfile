# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    x11vnc \
    xvfb \
    fluxbox \
    xterm \
    wget \
    supervisor \
    pkg-config \
    libcairo2-dev \
    libgirepository1.0-dev \
    gir1.2-gtk-3.0 \
    build-essential \
    libayatana-appindicator3-dev \
    novnc \
    websockify \
    git

# Export the display
ENV DISPLAY=:0

# Set the default VNC password
ENV VNC_PASSWORD="default_password"

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the noVNC port only
EXPOSE 6080

# Add supervisor configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start the services
CMD ["/usr/bin/supervisord"]