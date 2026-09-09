#!/usr/bin/env bash
# Taklifnomani GitHub tashkilotiga joylash.
#
#   ./deploy-org.sh [tashkilot-nomi]
#
# Standart nom: boburbek-sevinchxon  ->  https://boburbek-sevinchxon.github.io
#
# ESLATMA: bu skript eski repozitoriyga ham, eski saytga ham tegmaydi.
# U faqat tashkilotda YANGI repo ochib, shu papkadagi fayllarni yuboradi.

set -euo pipefail

ORG="${1:-boburbek-sevinchxon}"
REPO="${ORG}.github.io"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESC="Boburbek va Sevinchxon larning nikoh oqshomi taklifnomasi — 4-oktabr, soat 18:00, \"Tanho\" to'yxonasi"

say() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }

say "1/5  Tashkilot tekshirilmoqda: $ORG"
if ! gh api "orgs/$ORG" --jq .login >/dev/null 2>&1; then
  echo "XATO: '$ORG' nomli tashkilot topilmadi yoki unga kirish huquqi yo'q."
  echo "      Avval https://github.com/organizations/plan orqali bepul tashkilot oching."
  exit 1
fi
echo "     OK — tashkilot mavjud."

say "2/5  Repozitoriy: $ORG/$REPO"
if gh api "repos/$ORG/$REPO" --jq .full_name >/dev/null 2>&1; then
  echo "     Allaqachon mavjud — o'tkazib yuborildi."
else
  gh repo create "$ORG/$REPO" --public --description "$DESC" >/dev/null
  echo "     Yaratildi."
fi

say "3/5  Fayllar yuborilmoqda"
cd "$SRC"
git remote remove org 2>/dev/null || true
git remote add org "https://github.com/$ORG/$REPO.git"
git push -u org main
echo "     Yuborildi."

say "4/5  GitHub Pages yoqilmoqda"
if gh api "repos/$ORG/$REPO/pages" --jq .html_url >/dev/null 2>&1; then
  echo "     Allaqachon yoqilgan."
else
  gh api -X POST "repos/$ORG/$REPO/pages" \
    -f 'source[branch]=main' -f 'source[path]=/' --jq .html_url
fi

say "5/5  Build kutilmoqda (odatda 1-2 daqiqa)"
for i in $(seq 1 25); do
  ST="$(gh api "repos/$ORG/$REPO/pages" --jq .status 2>/dev/null || echo '?')"
  printf '     urinish %2d: %s\n' "$i" "$ST"
  [ "$ST" = "built" ] && break
  sleep 12
done

URL="https://${ORG}.github.io/"
CODE="$(curl -s -o /dev/null -w '%{http_code}' "$URL")"
AUDIO="$(curl -s -o /dev/null -w '%{http_code}' "${URL}music.m4a")"

say "TAYYOR"
echo "     Yangi sayt : $URL   (HTTP $CODE)"
echo "     Musiqa     : ${URL}music.m4a   (HTTP $AUDIO)"
echo "     Eski sayt  : https://shahriyorshomamatov-ctrl.github.io/boburbek-va-sevinchxon-nikoh-oqshomi-taklifnomasi/  (tegilmadi)"
