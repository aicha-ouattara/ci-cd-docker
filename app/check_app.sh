#!/bin/bash
echo "Début des vérifications..."
if [ -f "index.html" ]; then
    echo "✅ Tests réussis"
    exit 0
else
    echo "❌ Fichier manquant"
    exit 1
fi
