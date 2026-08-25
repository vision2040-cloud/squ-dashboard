# 🚀 PUSH INSTRUCTIONS - تعليمات الدفع السريعة

## ⚡ الطريقة الأسرع

### الخطوة 1: استخدام GitHub CLI (إن كان مثبتاً)

```powershell
gh auth login
git push origin main
```

### الخطوة 2: إذا لم ينجح، استخدم Token

1. اذهب إلى: https://github.com/settings/tokens
2. اضغط "Generate new token" → "Generate new token (classic)"
3. الصلاحيات: اختر `repo`
4. انسخ التوكن

ثم:
```powershell
$token = "ghp_YOUR_TOKEN_HERE"
git push https://${token}@github.com/vision2040-cloud/squ-dashboard.git main
```

### الخطوة 3: من GitHub Web مباشرة (الأسهل)

1. اذهب إلى: https://github.com/vision2040-cloud/squ-dashboard
2. اضغط على `index.html`
3. اضغط ✏️ (Edit)
4. استبدل المحتوى بنسخ من الملف المحلي
5. اضغط "Commit changes"

---

## 📊 الحالة الحالية

```
✓ تم تطبيق الإصلاح محلياً
✓ تم الالتزام (commit 707cbf9)
⏳ في الانتظار: الدفع إلى GitHub
```

---

## 📝 التعديلات المعلقة

```
Commit: 707cbf9
Message: FIX: Handle baseline=target case in calcComp (indicator 1.3)
Files: index.html (+5, -2)
```

---

## ✅ بعد الدفع

1. انتظر 30-60 ثانية
2. افتح: https://vision2040-cloud.github.io/squ-dashboard/
3. تحديث بقوة: `Ctrl+Shift+R`
4. تحقق من:
   - المؤشر 1.3: يجب أن يظهر **100%**
   - الشريط: يجب أن يكون **مرئي**

---

## 🆘 إذا حدثت مشكلة

```powershell
# تحقق من حالة المستخزن
git status

# اعرض آخر commit
git log --oneline -1

# اعرض التعديلات
git diff HEAD~1
```

---

## 📞 المساعدة

قم بأحد هذه:
1. اتبع الخطوة 1 أو 2 أو 3 أعلاه
2. إذا فشلت جميع الطرق: استخدم الخطوة 3 (GitHub Web)

