# Use a tiny nginx image
FROM nginx:alpine

# Work in nginx's default html directory
WORKDIR /usr/share/nginx/html

# Copy the ERD image into the container
COPY BookWormLibraryManagementSystemERD.png ./BookWormLibraryManagementSystemERD.png

# Create a super simple index.html to display the image
# (You can also keep your own index.html and COPY it instead.)
RUN printf '%s\n' \
  '<!doctype html>' \
  '<html lang="en">' \
  '<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">' \
  '<title>BookWorm ERD</title></head>' \
  '<body style="margin:0;display:flex;align-items:center;justify-content:center;min-height:100vh;background:#111">' \
  '<img src="BookWormLibraryManagementSystemERD.png" alt="ERD" style="max-width:95vw;max-height:95vh;border:8px solid #fff;border-radius:12px;box-shadow:0 10px 40px rgba(0,0,0,.6)">' \
  '</body></html>' \
  > index.html

# Nginx already exposes 80
EXPOSE 80

# Default nginx start command is fine

