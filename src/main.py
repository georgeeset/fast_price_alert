""" Module for initializing uvicorn address and port"""
import uvicorn


if __name__ == "__main__":
    uvicorn.run("v1.app:app", host="0.0.0.0", port=5000, reload=True)
