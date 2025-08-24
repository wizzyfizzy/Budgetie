# Budgetie Backend

A simple RESTful backend built with **Node.js** and **Express**  

---

## Setup Express Backend

Steps to set up a basic Express backend with initial folder structure:

### 1. 📂 Navigate to the `api/` folder:
```bash
cd api/
```

### 2. 📦 Initialize a new Node.js project:
```bash
npm init -y
```

### 3. 📚 Install essential dependencies:
```bash
npm install express cors dotenv
npm install --save-dev nodemon
```

### 4. 🗂 Create basic folder structure and files:
```bash
mkdir src
touch src/index.js
touch .env
touch .gitignore
```

### ✍️ Add the following code to src/index.js:
```js
const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Budgetie API is running 🎉");
});

app.listen(PORT, () => {
  console.log(`🚀 Server is running on port ${PORT}`);
});
```

### 5. 📝 Add .gitignore with:
```bash
node_modules/
.env
```

### 6. 🔄 Add start & dev scripts to package.json:
```json
"scripts": {
  "start": "node src/index.js",
  "dev": "nodemon src/index.js"
}
```


### 7. Create a `.env` file:
```
JWT_SECRET=supersecretkey
JWT_EXPIRES_IN=1h
```

---

## 🧪 Test the setup:
To start the backend server, follow these steps:

- Open your terminal and navigate to the `api` directory:

```bash
cd api
```
   
- Install dependencies (only the first time):

```bash
npm install
```

- Run the development server:

```bash
npm run dev
```

This will start the Express server with nodemon for automatic restarts on file changes.
You should see:
🚀 Server is running on port 5000

### Note:
Make sure you run these commands inside the api folder, where the package.json file is located.

---

# Auth
Built with **JWT**, and **bcrypt**.  
It provides signup & login functionality and stores users in a local JSON file.


## 🚀 Features
1. **User Signup** – create new accounts with `name`, `email`, and `password`.
2. **User Login** – validate credentials and issue JWT tokens.
3. **Password Security** – passwords are stored as **bcrypt hashes**, not plain text.
4. **Token-based Auth** – returns a signed JWT that can be used for authenticated requests.

---

## 📂 Project Structure
```
/routes
└── auth.js # Auth routes (signup, login)
/utils
└── fileDb.js # JSON file read/write helpers
users.json # Local user store
server.js # Entry point
.env # Environment variables
```

---

## 🔑 API Endpoints:
### 1. Signup
Creates user, stores password hashed with bcrypt, returns JWT.
```
{
  "name": "Kris",
  "email": "kris@test.com",
  "password": "123456"
}
```
URL:
`POST http://localhost:8000/auth/signup`

Headers:
`Content-Type: application/json`

Body:
```
{
  "name": "Kris",
  "email": "kris@test.com",
  "password": "123456"
}

```

Response:
```
{ 
    "message":"User created successfully",
    "user":{
        "id":"4c86ed5b-aa15-4dc8-b6a5-33341f34148e",
        "name":"Kris",
        "email":"kris@test.com"
    },
    "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRjODZlZDViLWFhMTUtNGRjOC1iNmE1LTMzMzQxZjM0MTQ4ZSIsImVtYWlsIjoia3Jpc0B0ZXN0LmNvbSIsIm5hbWUiOiJLcmlzIiwiaWF0IjoxNzU1OTQ3Mjk2LCJleHAiOjE3NTU5NTA4OTZ9.vMp-_M3wlCQ_EepFIkfW8ODUsXLz1SI26Lc2LqiI8JE"
}
```

### 2. Login
Validates user, returns JWT on success.
URL:
`POST http://localhost:8000/auth/login`

Headers:
`Content-Type: application/json`

Body:
```
{
  "email": "kris@test.com",
  "password": "123456"
}

```

Response:
```
{ 
    "message":"Login successful",
    "user":{
        "id":"4c86ed5b-aa15-4dc8-b6a5-33341f34148e",
        "name":"Kris",
        "email":"kris@test.com"
    },
    "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRjODZlZDViLWFhMTUtNGRjOC1iNmE1LTMzMzQxZjM0MTQ4ZSIsImVtYWlsIjoia3Jpc0B0ZXN0LmNvbSIsIm5hbWUiOiJLcmlzIiwiaWF0IjoxNzU1OTQ3MzE2LCJleHAiOjE3NTU5NTA5MTZ9.7Z7OPQkgLvqDYo-ZC5fh4dX_R1BCza6da3mmKUOtgvs"
}
```


### 3. Forgot Password (Request reset)
URL:
`POST http://localhost:8000/auth/forgot-password`

Headers:
`Content-Type: application/json`

Body:
```
{
  "email": "kris@test.com"
}
```

Response:
```
{
  "message": "Password reset token generated"
}
```

### 🧪 Test with curl
Signup
```
curl -X POST http://localhost:8000/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"name":"Kris","email":"kris@test.com","password":"123456"}'
```

Login
```
curl -X POST http://localhost:8000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"kris@test.com","password":"123456"}'
```

Forgot Password
```
curl -X POST http://localhost:8000/auth/forgot-password \
  -H "Content-Type: application/json" \
  -d '{"email":"kris@test.com"}'
```
