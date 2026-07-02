# 1. 使用官方穩定的 Python 3.10 輕量版作為基底鏡像
FROM python:3.10-slim

# 2. 設定工作目錄
WORKDIR /app

# 3. 安裝系統依賴套件
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. 複製專案內的依賴清單並安裝
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. 複製專案所有代碼到容器內
COPY . .

# 6. 【關鍵修正】刪除了原本的 chmod 腳本行，改為直接指定環境變數與核心程式啟動
ENV PYTHONUNBUFFERED=1

# 7. 啟動指令，直接運行專案的進入點（通常是 app.py）
CMD ["python3", "app.py"]
