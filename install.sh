#!/bin/bash

# رنگ‌ها برای خروجی زیباتر
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# تابع نمایش بار پیشرفت
show_progress() {
    echo -ne "${CYAN}"
    for i in {1..50}; do
        echo -n "█"
        sleep 0.03
    done
    echo -e "${NC}"
}

# هدر خوش‌آمدگویی
echo -e "${BLUE}========================================${NC}"
echo -e "${YELLOW}   نصب‌کنندهٔ اسکیل لاکی (Lucky Scale)${NC}"
echo -e "${BLUE}========================================${NC}"
echo

# درخواست رمز
read -sp "لطفاً رمز نصب را وارد کنید: " PASSWORD
echo

if [ "$PASSWORD" != "1424lucky2014" ]; then
    echo -e "${RED}❌ رمز اشتباه است! نصب متوقف شد.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ رمز تأیید شد. شروع فرآیند نصب...${NC}"
sleep 1

# مرحله‌های ساختگی نصب
echo -e "${YELLOW}⏳ بررسی وابستگی‌ها...${NC}"
sleep 1
echo -e "   - پیدا کردن بسته‌های مورد نیاز... ${GREEN}موفق${NC}"
sleep 0.5
echo -e "   - نصب پیش‌نیازها (ساختگی)..."
show_progress
echo -e "   - ${GREEN}همه پیش‌نیازها نصب شدند.${NC}"
sleep 0.5

echo -e "${YELLOW}⏳ ایجاد دایرکتوری‌های مورد نیاز...${NC}"
mkdir -p /tmp/lucky_scale 2>/dev/null
echo -e "   - دایرکتوری /tmp/lucky_scale ساخته شد."
sleep 0.5

echo -e "${YELLOW}⏳ کپی فایل‌های اصلی...${NC}"
for i in {1..5}; do
    echo -ne "   - کپی فایل $i از 5 ... "
    sleep 0.3
    echo -e "${GREEN}انجام شد${NC}"
done
sleep 0.5

echo -e "${YELLOW}⏳ تنظیم مجوزها...${NC}"
chmod 755 /tmp/lucky_scale 2>/dev/null
echo -e "   - مجوزها با موفقیت تنظیم شدند."
sleep 0.5

echo -e "${YELLOW}⏳ نصب سرویس (شبیه‌سازی)...${NC}"
echo -e "   - راه‌اندازی سرویس lucky-scale..."
show_progress
echo -e "   - ${GREEN}سرویس با موفقیت راه‌اندازی شد.${NC}"
sleep 0.5

# پیام نهایی با آرت‌اسکی
echo
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                          ║${NC}"
echo -e "${GREEN}║      ${CYAN}اسکیل لاکی با موفقیت نصب شد!${GREEN}     ║${NC}"
echo -e "${GREEN}║                                          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo
echo -e "${BLUE}نسخه: 2.4.1 (Lucky Edition)${NC}"
echo -e "${BLUE}تاریخ نصب: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo
echo -e "${YELLOW}برای اطلاعات بیشتر به README مراجعه کنید.${NC}"
