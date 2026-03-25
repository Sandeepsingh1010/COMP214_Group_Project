#!/usr/bin/env bash
set -e

git init
git add .
git commit -m "Initial COMP214 group project skeleton"
echo "Repository initialized."
echo "Next:"
echo "  git branch -M main"
echo "  git remote add origin <YOUR_GITHUB_REPO_URL>"
echo "  git push -u origin main"
