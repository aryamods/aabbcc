FROM python:3.13-slim

WORKDIR /app

# Install system dependencies untuk OpenCV headless
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements terlebih dahulu
COPY requirements.txt .

# Hapus instalasi opencv sebelumnya (jika ada) dan install yang headless
RUN pip install --no-cache-dir --upgrade pip && \
    pip uninstall -y opencv-python opencv-contrib-python || true && \
    pip install --no-cache-dir \
        opencv-python-headless==4.10.0.84 \
        mediapipe \
        tensorflow-cpu \
        fastapi \
        uvicorn \
        numpy \
        httpx \
        python-multipart \
        matplotlib \
        reportlab \
        json-repair \
        python-dotenv \
        gdown

COPY . .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
