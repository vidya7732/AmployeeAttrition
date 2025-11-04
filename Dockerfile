# 🐍 Use official lightweight Python image
FROM python:3.10-slim

# 👷‍♀️ Set working directory
WORKDIR /app

# 🧾 Copy and install dependencies safely
COPY requirements.txt .

# Upgrade pip and install dependencies with SSL fix
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --trusted-host pypi.org \
    --trusted-host pypi.python.org \
    --trusted-host files.pythonhosted.org \
    -r requirements.txt

# 📦 Copy all project files
COPY . .

# 🌐 Expose both ports (FastAPI + Streamlit)
EXPOSE 8000
EXPOSE 8501

# 🏃 Run FastAPI and Streamlit together
CMD ["sh", "-c", "uvicorn mamfastapi:app --host 0.0.0.0 --port 8000 & streamlit run mamstreamlit.py --server.port 8501 --server.address 0.0.0.0"]
