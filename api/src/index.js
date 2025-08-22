const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = 8000;

app.use(cors());
app.use(express.json());

// Mount auth router
const authRouter = require("./routes/auth");

app.use((req, res, next) => {
  console.log("[REQUEST HIT]", req.method, req.url);
  next();
});

app.use("/auth", authRouter);

app.get("/", (req, res) => {
  res.send("Budgetie API is running 🎉");
});

app.listen(PORT, () => {
  console.log(`🚀 Server is running on port ${PORT}!!`);
});
