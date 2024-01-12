#!/bin/bash

# Mevcut dal adını al
current_branch=$(git symbolic-ref --short HEAD)

# Hedef dal adı
target_branch="development"

# Hedef dalı güncelle
git checkout $target_branch
git pull

# Mevcut dalı güncelle ve rebase işlemini gerçekleştir
echo "Rebasing $current_branch to $target_branch"
git checkout $current_branch
git rebase $target_branch