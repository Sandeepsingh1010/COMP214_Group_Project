# 🧑‍💻 COMP214 Group Project – Team Setup Guide

## 📌 Overview

This project uses:

* **GitHub** → for collaboration & version control
* **Oracle SQL Developer** → for writing and running SQL
* **Individual schemas** → each member develops independently

⚠️ Important:
Each person works in **their own Oracle schema**, NOT directly in someone else’s.

---

## 🚀 Initial Setup (Do this once)

### 1. Clone the Repository

```bash
git clone https://github.com/Sandeepsingh1010/COMP214_Group_Project
cd COMP214_Group_Project
```

---

### 2. Create Your Branch

Each member works in their own branch:

```bash
git checkout -b yourname-feature
```

Example:

```bash
git checkout -b ali-tables
```

---

### 3. Open Project in SQL Developer

* Open **Oracle SQL Developer**
* Go to **View → Files**
* Navigate to your cloned repo folder
* Open `.sql` files from there

---

### 4. Create Your Database Connection

Use your **own Oracle account**:

* Username: your college DB user
* Password: your password
* Host / Port / Service: (provided by college)

---

## 💻 Daily Workflow

### Step 1: Pull Latest Changes

```bash
git pull origin main
```

---

### Step 2: Work on Your Assigned Files

Go to:

```
sql/02_tasks/
```

Each member edits ONLY their assigned file(s).

Example:

```
task_01_tables.sql
task_02_queries.sql
task_03_procedures.sql
```

---

### Step 3: Run Code in SQL Developer

* Open your `.sql` file
* Connect to your schema
* Run using:
  ▶️ Run Script (F5)

---

### Step 4: Save + Commit

```bash
git add .
git commit -m "Added tables for Task 1"
git push origin your-branch-name
```

---

### Step 5: Create Pull Request

* Go to GitHub
* Open a **Pull Request → main**
* Wait for review before merging

---

## ⚠️ Team Rules

### ✅ DO

* Work only in your assigned files
* Test everything in your own schema
* Write clean, readable SQL
* Commit frequently

---

### ❌ DO NOT

* ❌ Push directly to `main`
* ❌ Edit someone else’s task file
* ❌ Work only in SQL Developer without saving `.sql` files
* ❌ Break existing scripts

---

## 🧩 Database Rules

* Each member uses their **own schema**
* No shared editing of database objects

---

## 🔐 Optional: Sharing Access (If Needed)

If someone needs access to your object:

```sql
GRANT SELECT ON your_table TO teammate;
GRANT EXECUTE ON your_procedure TO teammate;
```

---

## 📦 Final Integration (Handled by Team Lead)

* All files will be combined into:

```
sql/99_build/Group5.sql
```

This file will:

* Run everything in correct order
* Be used for final submission

---

## 📁 Project Structure

```
sql/
├── 01_tables/
├── 02_tasks/
├── 03_tests/
├── 04_views/
├── 05_procedures/
├── 06_triggers/
├── 07_packages/
└── 99_build/
```

---

## 🧠 Tips

* Run scripts in order (tables → data → logic)
* Use comments in SQL:

```sql
-- This creates customer table
```

* Keep things simple and working

---

## 👥 Team Communication

If unsure:

* Ask before changing shared structure
* Don’t guess and break things
* Keep commits clear

---

## ✅ Summary

| Tool          | Purpose             |
| ------------- | ------------------- |
| GitHub        | Collaboration       |
| SQL Developer | Write/run SQL       |
| Your Schema   | Development/testing |
| Final Script  | Submission          |

---

🔥 Goal:
Work independently → merge cleanly → produce ONE working final SQL file.

---
