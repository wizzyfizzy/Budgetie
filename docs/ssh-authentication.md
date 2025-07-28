# 🔐 SSH Authentication Setup for GitHub

Follow these steps to configure SSH authentication for your GitHub repository (instead of using HTTPS with token/password).

---

## ✅ Step 1: Check if you already have an SSH key

Open a terminal and run:

```bash
ls -al ~/.ssh
```

If you see files like:

- `id_rsa` and `id_rsa.pub`  
- `id_ed25519` and `id_ed25519.pub`  

...then you already have an SSH key. You can skip to **Step 3**.

---

## 🔨 Step 2: Generate a new SSH key

Run the appropriate command in your terminal:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

If you're using an older version of macOS that doesn’t support `ed25519`, use:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

When prompted:

- Press `Enter` to accept the default file location  
- Press `Enter` to leave the passphrase empty (or choose one if preferred)  
- Confirm with another `Enter`

---

## ✅ Step 3: Add the SSH key to the SSH agent

Start the agent:

```bash
eval "$(ssh-agent -s)"
```

Then add your key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Or if using RSA:

```bash
ssh-add ~/.ssh/id_rsa
```

---

## ✅ Step 4: Copy your public key

For `ed25519`:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

Or for RSA:

```bash
pbcopy < ~/.ssh/id_rsa.pub
```

Now the key is in your clipboard.

---

## ✅ Step 5: Add the SSH key to your GitHub account

1. Go to: [https://github.com/settings/keys](https://github.com/settings/keys)  
2. Click **New SSH key**  
3. Set a title (e.g., "MacBook SSH")  
4. Paste your key into the **Key** field  
5. Click **Add SSH key**

---

## 🧪 Final Test

Run this to verify your SSH connection:

```bash
ssh -T git@github.com
```

You should see something like:

```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 🎉 Done

You're now using SSH authentication with GitHub.
