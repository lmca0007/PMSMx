# Dev image: Rapoid development with Jupyter notebooks
FROM dolfinx/lab:stable

# Set working directory
WORKDIR /home/fenics/app

# Copy only requirements.txt
COPY requirements.txt ./ 

# Install Python requirements
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install --no-cache-dir -r requirements.txt

# Expose Jupyter port
EXPOSE 8888

# Entrypoint allows either Jupyter or arbitrary commands
ENTRYPOINT ["/home/fenics/app/entrypoint.sh"]
CMD ["jupyter"]
