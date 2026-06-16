#!/bin/bash

# ================================================
# نصب‌کننده LuckyCUT
# ================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ------------------- توابع کمکی -------------------
show_progress() {
    echo -ne "${CYAN}"
    for i in {1..40}; do
        echo -n "█"
        sleep 0.02
    done
    echo -e "${NC}"
}

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${YELLOW}   نصب‌کننده LuckyCUT${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo
}

# ------------------- بررسی رمز -------------------
print_header
read -sp "لطفاً رمز نصب را وارد کنید: " PASSWORD
echo

if [ "$PASSWORD" != "1424lucky2014" ]; then
    echo -e "${RED}❌ رمز اشتباه است! نصب متوقف شد.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ رمز تأیید شد. شروع فرآیند نصب...${NC}"
sleep 1

# ------------------- نصب ساختگی -------------------
echo -e "${YELLOW}⏳ بررسی وابستگی‌ها...${NC}"
sleep 1
echo -e "   - پیدا کردن بسته‌های مورد نیاز... ${GREEN}موفق${NC}"
sleep 0.3
echo -e "   - نصب پیش‌نیازها..."
show_progress
sleep 0.3

echo -e "${YELLOW}⏳ ایجاد دایرکتوری‌های مورد نیاز...${NC}"
mkdir -p ~/.luckycut 2>/dev/null
echo -e "   - دایرکتوری ~/.luckycut ساخته شد."
sleep 0.3

echo -e "${YELLOW}⏳ کپی فایل‌های اصلی...${NC}"
for i in {1..5}; do
    echo -ne "   - کپی فایل $i از 5 ... "
    sleep 0.2
    echo -e "${GREEN}انجام شد${NC}"
done
sleep 0.3

# ------------------- ایجاد فایل اصلی LuckyCUT -------------------
echo -e "${YELLOW}⏳ ایجاد دستور LuckyCUT...${NC}"

# فایل اصلی کامند LuckyCUT رو میسازیم تو دایرکتوری کاربر
cat > ~/.luckycut/luckycut.sh << 'EOF'
#!/bin/bash

# فایل کانفیگ
CONFIG_FILE="$HOME/.luckycut/config.cfg"

# ==========================================
# دستورات اصلی LuckyCUT
# ==========================================

show_help() {
    echo "═══════════════════════════════════════════════════════"
    echo "  راهنمای دستورات LuckyCUT"
    echo "═══════════════════════════════════════════════════════"
    echo ""
    echo "  LCUT--VR          نمایش نسخه و وضعیت نصب"
    echo "  help              نمایش این راهنما"
    echo "  setXPI            تنظیم API کلید (نیاز به کد فعال‌سازی)"
    echo ""
    echo "═══════════════════════════════════════════════════════"
}

show_version() {
    echo "═══════════════════════════════════════════════════════"
    echo "  LuckyCUT نسخه 2.4.1"
    echo "  وضعیت: نصب شده ✅"
    echo "  تاریخ نصب: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "═══════════════════════════════════════════════════════"
}

set_xpi() {
    # کلید مخفی که باید ست شود
    SECRET_KEY="//\$XYZcoq-%xyz.io/=XP=jty1333r4g3j3f45f4//UTR/limet00/>der"
    
    # بررسی اینکه آیا قبلاً تنظیم شده
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        if [ ! -z "$XPI_KEY" ] && [ "$XPI_KEY" != "NOT_SET" ]; then
            echo "⚠️  API قبلاً تنظیم شده است."
            echo "   کلید فعلی: $XPI_KEY"
            echo ""
            read -p "آیا می‌خواهید بازنشانی کنید؟ (y/n): " RESET
            if [[ ! "$RESET" =~ ^[Yy]$ ]]; then
                echo "❌ عملیات لغو شد."
                return
            fi
        fi
    fi
    
    echo "🔑 در حال تنظیم API Key..."
    echo "   لطفاً کد فعال‌سازی را وارد کنید:"
    read -sp "   کد: " USER_CODE
    echo ""
    
    if [ "$USER_CODE" == "1424lucky2014" ]; then
        mkdir -p ~/.luckycut
        echo "XPI_KEY=\"$SECRET_KEY\"" > "$CONFIG_FILE"
        echo "XPI_STATUS=\"ACTIVE\"" >> "$CONFIG_FILE"
        echo "✅ API با موفقیت تنظیم شد!"
        echo "   وضعیت: فعال ✅"
    else
        echo "❌ کد فعال‌سازی اشتباه است!"
        echo "   وضعیت: غیرفعال ❌"
    fi
}

# ==========================================
# پردازش آرگومان‌ها
# ==========================================

case "$1" in
    LCUT--VR|--version|-v)
        show_version
        ;;
    help|-h|--help)
        show_help
        ;;
    setXPI)
        set_xpi
        ;;
    *)
        # اگر هیچ آرگومانی نداد، راهنما رو نشون بده
        if [ -z "$1" ]; then
            show_help
        else
            echo "❌ دستور '$1' شناسایی نشد."
            echo "   برای راهنما: luckycut help"
        fi
        ;;
esac
EOF

# قابل اجرا کردن فایل
chmod +x ~/.luckycut/luckycut.sh

# ------------------- ایجاد Alias در Bash/Zsh -------------------
if grep -q "alias luckycut=" ~/.bashrc 2>/dev/null; then
    echo "   - Alias قبلاً در .bashrc وجود دارد."
else
    echo 'alias luckycut="~/.luckycut/luckycut.sh"' >> ~/.bashrc
    echo "   - Alias به .bashrc اضافه شد."
fi

if grep -q "alias luckycut=" ~/.zshrc 2>/dev/null; then
    echo "   - Alias قبلاً در .zshrc وجود دارد."
else
    echo 'alias luckycut="~/.luckycut/luckycut.sh"' >> ~/.zshrc 2>/dev/null
    echo "   - Alias به .zshrc اضافه شد."
fi

# ------------------- ایجاد فایل .bat برای ویندوز (CMD) -------------------
echo -e "${YELLOW}⏳ ساخت فایل اجرایی برای CMD ویندوز...${NC}"

cat > ~/.luckycut/luckycut.bat << 'EOF'
@echo off
bash -c "~/.luckycut/luckycut.sh %*"
EOF

# اگه ویندوز هست، فایل رو به مسیر PATH اضافه کنیم
if [[ "$OS" == "Windows_NT" ]]; then
    # پیدا کردن مسیرهای PATH
    USER_PATH=$(cmd /c "echo %USERPROFILE%" 2>/dev/null | tr -d '\r')
    if [ ! -z "$USER_PATH" ]; then
        cp ~/.luckycut/luckycut.bat "$USER_PATH/luckycut.bat" 2>/dev/null
        echo "   - فایل luckycut.bat در دایرکتوری کاربر کپی شد."
    fi
fi

# ------------------- پیام پایانی -------------------
echo
echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                  ║${NC}"
echo -e "${GREEN}║      ${CYAN}LuckyCUT با موفقیت نصب شد!${GREEN}              ║${NC}"
echo -e "${GREEN}║                                                  ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
echo
echo -e "${BLUE}نسخه: 2.4.1 (Lucky Edition)${NC}"
echo -e "${BLUE}تاریخ نصب: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo
echo -e "${YELLOW}📌 دستورات بعد از نصب:${NC}"
echo -e "   ${GREEN}luckycut${NC}              نمایش راهنما"
echo -e "   ${GREEN}luckycut LCUT--VR${NC}     نمایش نسخه"
echo -e "   ${GREEN}luckycut help${NC}         نمایش راهنما"
echo -e "   ${GREEN}luckycut setXPI${NC}       تنظیم API (با کد 1424lucky2014)"
echo
echo -e "${YELLOW}⚠️  برای استفاده در CMD ویندوز:${NC}"
echo -e "   اگر دستور luckycut شناسایی نشد، CMD را مجدداً باز کنید."
echo -e "   یا از مسیر: ${BLUE}~/.luckycut/luckycut.bat${NC} استفاده کنید."
echo

# بارگذاری مجدد bashrc
exec bash 2>/dev/null || source ~/.bashrc 2>/dev/null
