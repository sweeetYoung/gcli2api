# 基础镜像
FROM python:3.13-slim

# 设置工作目录
WORKDIR /app

# 复制依赖文件并安装 Python 依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制其余代码
COPY . .

# 设置默认密码环境变量（可在 HF 上覆盖）
ENV PASSWORD=pwd

# Hugging Face 会自动启动 ASGI app，这里直接让 hypercorn 监听 $PORT
CMD ["hypercorn", "web:app", "--bind", "0.0.0.0:$PORT", "--log-level", "info"]
