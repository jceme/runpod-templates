"""
Example template application.
This demonstrates how to extend a Runpod base image.
"""

import sys

def main():
    print("Hello from your Runpod template!")
    print(f"Python version: {sys.version}")
    
    # Add your application logic here
    # Example: import torch
    # print(f"PyTorch version: {torch.__version__}")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())

