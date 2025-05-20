# Fullstack App

This project is a fullstack web application consisting of a **React frontend**, a **Go backend**, and a **PostgreSQL database**, all containerized using Docker and orchestrated with Docker Compose.

---

## 📁 Project Structure

    fullstack-app/                       
    │── frontend/                 
    │   ├── Dockerfile       
    │   ├── frontend code             
    │   └── .env 
    │
    ├── backend/                 
    │   ├── Dockerfile                
    │   └── backend code  
    │         
    ├── docker-compose.yml       
    ├── .env
    │
    └── README.md                  # You're here!
---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/fullstack-app.git
cd fullstack-app
```

### 2. Configure Environment Variables

Create a `.env` file in the root with the following content (adjust values as needed):

- DB_USER=your_db_user
- DB_PASSWORD=your_db_password
- DB_NAME=your_db_name
- DB_PORT=5432
- ALLOWED_ORIGINS=*

Also make sure frontend/.env exists:

- REACT_APP_SERVER_URL=/api/employees


### 3. Build Docker Images

** 🔧 Frontend **
```bash
cd frontend
docker build -t your-dockerhub-username/nodefrontendappimage .
```

** 🔧 Backend **
```bash
cd ../backend
docker build -t your-dockerhub-username/gobackendappimage .
```

**Make sure you're logged in to Docker Hub: **

```bash
docker login
```

**🚀 Push Frontend Image **
```bash
docker push your-dockerhub-username/nodefrontendappimage
```

**🚀 Push Backend Image **
```bash
docker push your-dockerhub-username/gobackendappimage
```

### 4. Update **docker-compose.yml**
Ensure your docker-compose.yml uses the correct image names (as shown below):

```yaml
services:
  backend:
    image: your-dockerhub-username/gobackendappimage
    ...

  frontend:
    image: your-dockerhub-username/nodefrontendappimage
    ...
```
> ✅ Replace your-dockerhub-username with your actual Docker Hub username.


### 5. Run the Application
From the root directory of the project:

```bash
docker-compose up -d
```

- Frontend will be available at: http://localhost:3000
- Backend will be accessible internally at: http://backend:8080 (proxied by the frontend)
- PostgreSQL runs internally on port 5432


### 🛠 Notes
- The frontend uses Nginx to serve the built React app.
- The backend is a compiled Go binary.
- Environment variables for database connection and CORS are provided via .env.

