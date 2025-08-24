const express = require("express");
const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcrypt");
const { readUsers, writeUsers } = require("../utils/fileDb");
require("dotenv").config();

const router = express.Router();

// Helper for token
function generateToken(user) {
  return jwt.sign(
    { id: user.id, email: user.email, name: user.name }, // περιέχει και id
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || "1h" }
  );
}

// SIGN UP
router.post("/signup", async (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password) {
    return res.status(400).json({ error: "MissingFields" });
  }

  const users = readUsers();
  if (users.find((u) => u.email === email)) {
    return res.status(400).json({ error: "UserExists" });
  }

  // Hash password before the save
  const hashedPassword = await bcrypt.hash(password, 10);

  const newUser = { id: uuidv4(), name, email, password: hashedPassword };
  users.push(newUser);
  writeUsers(users);

  const token = generateToken(newUser);
  res.json({
    message: "User created successfully",
    user: { id: newUser.id, name: newUser.name, email: newUser.email },
    token,
  });
});

// LOGIN
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  console.log("Login attempt for:", email); // print email

  const users = readUsers();
  const user = users.find((u) => u.email === email);

  if (!user) {
    console.log("Login failed for:", email); // failed attempt
    return res.status(401).json({ error: "InvalidCredentials" });
  }

  // Check with bcrypt
  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) {
    return res.status(401).json({ error: "InvalidCredentials" });
  }

  const token = generateToken(user);
  console.log("Login successful for:", email);

  res.json({
    message: "Login successful",
    user: { id: user.id, name: user.name, email: user.email },
    token,
  });
});

router.post("/forgot-password", (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: "MissingFields" });
  }
  console.log("Forgot password for:", email);

  const users = readUsers();
  const user = users.find((u) => u.email === email);

  if (!user) {
    console.log("If an account with this email exists, a reset email has been sent.");
    return res.json({
      message: "If an account with this email exists, a reset email has been sent."
    });
  }

  // Dummy mail sending (console log instead of real SMTP)
  console.log(`[MAILER] Sending reset email to: ${email}`);

  return res.json({
    message: "Password reset email has been sent."
  });
});

module.exports = router;
