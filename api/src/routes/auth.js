const express = require("express");
const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");
const { readUsers, writeUsers } = require("../utils/fileDb");
require("dotenv").config();

const router = express.Router();

// Helper για token
function generateToken(user) {
  return jwt.sign(
    { id: user.id, email: user.email, name: user.name }, // περιέχει και id
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || "1h" }
  );
}

// SIGN UP
router.post("/signup", (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password) {
    return res.status(400).json({ error: "Name, email and password required" });
  }

  const users = readUsers();
  if (users.find((u) => u.email === email)) {
    return res.status(400).json({ error: "User already exists" });
  }

  const newUser = { id: uuidv4(), name, email, password };
  users.push(newUser);
  writeUsers(users);

  const token = generateToken(newUser);
  res.json({
    message: "User created successfully 🎉",
    user: { id: newUser.id, name: newUser.name, email: newUser.email },
    token,
  });
});

// LOGIN
router.post("/login", (req, res) => {
  const { email, password } = req.body;

  console.log("Login attempt for:", email); // print email

  const users = readUsers();
  const user = users.find((u) => u.email === email && u.password === password);

  if (!user) {
    console.log("Login failed for:", email); // failed attempt
    return res.status(401).json({ error: "InvalidCredentials" });
  }

  const token = generateToken(user);
  console.log("Login successful for:", email);
  console.log("Generated token:", token); // ⚠️ μόνο για development/debug

  res.json({
    message: "Login successful ✅",
    user: { id: user.id, name: user.name, email: user.email },
    token,
  });
});


module.exports = router;
