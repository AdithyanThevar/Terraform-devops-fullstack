# Fullstack App

A Dockerized fullstack application with a React frontend, Go backend, and PostgreSQL database. The frontend is served by Nginx and proxies API requests to the backend via Docker networking.

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


