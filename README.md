# COMP214 / Advanced Database Group Project Repo

This repository is a collaborative skeleton for the group PL/SQL project.

## Project goal
Build and test all required PL/SQL tasks in separate files, then combine them into **one final runnable SQL file** for submission in SQL Developer.

## Suggested workflow
1. Clone the repo
2. Create a branch for your task
3. Work only in your assigned task file
4. Add test blocks under `sql/03_tests/`
5. After review, merge into `main`
6. Copy final approved code into `sql/99_build/Group#.sql`
7. Run the full `Group#.sql` file top-to-bottom in Oracle SQL Developer before submitting

## Folder structure
- `sql/00_setup/` optional setup scripts and notes
- `sql/01_common/` shared helper objects
- `sql/02_tasks/` one task per file
- `sql/03_tests/` test/invocation scripts
- `sql/99_build/Group#.sql` final combined submission file
- `docs/` planning and team notes
- `screenshots/` execution screenshots for report submission

## Team branching suggestion
- `main` → stable approved code
- `task-01-factorial-procedure`
- `task-02-factorial-function`
- `task-03-calculate-salary`
- etc.

## Important submission note
The project handout says the final submission should be a **single text-based SQL file** that runs when the entire file is executed in SQL Developer, saved as `Group#.sql`. fileciteturn1file0L7-L18

## How to start
```bash
./init-git.sh
```
Then connect the repo to your GitHub remote.
