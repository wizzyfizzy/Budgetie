const fs = require("fs");
const path = require("path");

const usersFile = path.join(__dirname, "..", "DataBase", "users.json");

function readUsers() {
  if (!fs.existsSync(usersFile)) {
    fs.writeFileSync(usersFile, "[]");
  }
  const data = fs.readFileSync(usersFile);
  return JSON.parse(data);
}

function writeUsers(users) {
  fs.writeFileSync(usersFile, JSON.stringify(users, null, 2));
}

module.exports = { readUsers, writeUsers };
