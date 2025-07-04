FROM python:3.10-slim  
  
WORKDIR /app  
  
# Installer les dépendances système  
RUN apt-get update && apt-get install -y \  
    gcc \  
    g++ \  
    && rm -rf /var/lib/apt/lists/*  
  
# Copier et installer les dépendances Python  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
# Télécharger le modèle spaCy  
RUN python -m spacy download en_core_web_sm  
  

COPY create_admin.py ./  

  
# Copier le code de l'application  
COPY . .  
  
EXPOSE 8000  
  
CMD ["sh", "-c", "python create_admin.py && python manage.py runserver 0.0.0.0:8000"]
