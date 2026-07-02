# 1. 使用官方穩定的 Python 3.10 輕量版作為基底鏡像
FROM python:3.10-slim

# 2. 設定工作目錄
WORKDIR /app

# 3. 安裝系統依賴套件（LINE 轉接層與部分套件編譯可能需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. 複製專案內的依賴清單並安裝
COPY requirements.txt requirements-optional.txt* ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    if [ -f requirements-optional.txt ]; then pip install --no-cache-dir -r requirements-optional.txt; fi

# 5. 複製專案所有代碼到容器內
COPY . .

# 6. 給予啟動腳本執行權限（如果有的話）
RUN chmod +x entrypoint.sh

# 7. 啟動指令，直接運行專案的主程式 app.py
CMD ["python3", "app.py"]
