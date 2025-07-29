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

### 🧪 Test the setup:
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
