# 🔐 كيفية دفع التعديلات إلى GitHub

## ⚠️ المشكلة

يوجد خطأ مصادقة عند محاولة الدفع:
```
fatal: unable to access 'https://github.com/vision2040-cloud/squ-dashboard.git/': 
The requested URL returned error: 403
```

**السبب:** المصادقة عبر HTTPS بكلمة المرور لم تعد مدعومة من GitHub

## ✅ الحل

اتبع **أحد** هذه الطرق:

---

## الطريقة 1️⃣: استخدام GitHub CLI (الأسهل)

### الخطوة 1: تثبيت GitHub CLI

**Windows:**
```bash
winget install GitHub.cli
```

**macOS:**
```bash
brew install gh
```

**Linux:**
```bash
sudo apt install gh  # أو المعادل على توزيعتك
```

### الخطوة 2: التوثق

```bash
gh auth login
```

ثم اتبع التعليمات:
- اختر `HTTPS`
- اختر `Paste an authentication token`
- أو اتركها تفتح المتصفح للمصادقة التلقائية

### الخطوة 3: دفع التعديلات

```bash
git push origin main
```

---

## الطريقة 2️⃣: استخدام Personal Access Token

### الخطوة 1: إنشاء Personal Access Token

1. اذهب إلى: https://github.com/settings/tokens
2. اضغط "Generate new token" → "Generate new token (classic)"
3. سمّ التوكن: "squ-dashboard-push"
4. حدد الصلاحيات:
   - ✓ `repo` (كل الوصول للـ repositories)
   - ✓ `workflow` (إذا كان مطلوباً)
5. اضغط "Generate token"
6. **انسخ التوكن** (سيختفي بعد إغلاق الصفحة)

### الخطوة 2: تخزين التوكن بأمان

**Windows:**
```powershell
# استخدام Credential Manager
$token = "ghp_xxxxxxxxxxxxxxxxxxxx"  # ضع توكنك هنا
[System.Environment]::SetEnvironmentVariable("GH_TOKEN", $token, [System.EnvironmentVariableTarget]::User)
```

**macOS/Linux:**
```bash
# تخزين في ~/.bashrc أو ~/.zshrc
export GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"
```

### الخطوة 3: دفع باستخدام التوكن

```bash
git push https://<TOKEN>@github.com/vision2040-cloud/squ-dashboard.git main
```

أو باستخدام المتغير البيئي:
```bash
git push origin main
```

---

## الطريقة 3️⃣: استخدام SSH (الأكثر أماناً للمستقبل)

### الخطوة 1: إنشاء SSH Key

```bash
ssh-keygen -t ed25519 -C "vision2040@squ.edu.om"
```

اضغط Enter عند الأسئلة (بدون passphrase).

### الخطوة 2: إضافة المفتاح إلى GitHub

1. انسخ المفتاح العام:
```bash
cat ~/.ssh/id_ed25519.pub  # ثم انسخ الناتج
```

2. اذهب إلى: https://github.com/settings/keys
3. اضغط "New SSH key"
4. الصق المفتاح
5. اضغط "Add SSH key"

### الخطوة 3: تحديث الـ remote

```bash
git remote set-url origin git@github.com:vision2040-cloud/squ-dashboard.git
```

### الخطوة 4: دفع التعديلات

```bash
git push origin main
```

---

## الطريقة 4️⃣: دفع مباشرة من GitHub Web (بدون بحاجة للتوثق)

### الخطوة 1: الذهاب إلى GitHub

https://github.com/vision2040-cloud/squ-dashboard

### الخطوة 2: تحميل الملف المعدل

1. اذهب إلى الملف `index.html`
2. اضغط على أيقونة التحرير (✏️)
3. استبدل المحتوى بالملف المحدث
4. اضغط "Commit changes"

---

## 🧪 التحقق من الدفع

بعد الدفع بنجاح:

```bash
# تحقق من أن التعديلات تم دفعها
git log --oneline -3

# يجب أن ترى:
# f2c4e40 FIX: calcComp - return 0 instead of null...
# 1f3f406 update25
# bdcf2bb Create fix_calculations.ps1
```

---

## 🌐 التحقق من الموقع

1. انتظر 30-60 ثانية
2. افتح: https://vision2040-cloud.github.io/squ-dashboard/
3. تحديث بقوة: `Ctrl+Shift+R`
4. تحقق من أن النتائج تغيرت

---

## ❌ استكشاف الأخطاء

### خطأ: "fatal: could not read Username"

**الحل:** استخدم Personal Access Token بدلاً من كلمة المرور

### خطأ: "Permission denied (publickey)"

**الحل:** تحقق من أن SSH key موجود وصحيح:
```bash
ssh -T git@github.com
```

### خطأ: "fatal: 'origin' does not appear to be a 'git' repository"

**الحل:** تأكد أنك في مجلد المشروع:
```bash
pwd
ls -la | grep .git
```

---

## ✅ الطريقة الموصى بها

**للاستخدام السريع:** الطريقة 1️⃣ (GitHub CLI)
**للأمان على المدى الطويل:** الطريقة 3️⃣ (SSH)

---

## 📝 الملخص

التعديلات موجودة محلياً وجاهزة للدفع:

```bash
✓ Commit: f2c4e40 "FIX: calcComp..."
✓ الملف: index.html (28 تعديل)
✓ الاختبار: ✅ نجح محلياً
✓ الحالة: بانتظار الدفع
```

**بعد الدفع:**
- الموقع سيتحدث تلقائياً
- النتائج ستصبح صحيحة
- الشؤون الأكاديمية ستظهر بـ 25% (أو ما يقارب ذلك)

---

## 🎯 الخطوة التالية

**اختر أحد الطرق أعلاه وقم بالدفع، ثم:**

1. تحقق من git status:
```bash
git status
# يجب أن يظهر: "On branch main, nothing to commit"
```

2. تحقق من GitHub:
```
https://github.com/vision2040-cloud/squ-dashboard/commits/main
```

3. افتح الموقع وتحقق من النتائج الجديدة

