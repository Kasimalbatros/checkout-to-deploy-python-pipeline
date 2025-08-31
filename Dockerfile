# Use lightweight Python image
FROM python:3.9-slim

# Set work directory
WORKDIR /app

# Copy files
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Expose port 8000
EXPOSE 8000

# Run the app
CMD ["python", "app.py"]

