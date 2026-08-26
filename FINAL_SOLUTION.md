# ✅ الحل الصحيح النهائي

## 🎯 المشكلة:

البيانات من Google Sheets **لا تحتوي على قيمة `completion`** محسوبة مسبقاً.

يجب حسابها **ديناميكياً** باستخدام الصيغة الرياضية الصحيحة.

---

## ✅ الحل:

في `parseRowsFull()` - عند معالجة كل صف من CSV:

### موقع الإضافة:

ابحث عن الموقع حيث يتم إنشاء الـ object للمؤشر (سواء L2 أو L3 أو L4)

**أضف هذا السطر:**

```javascript
// بعد تعيين achieved, target, baseline مباشرة
row_obj.completion = calcComp(row_obj.achieved, row_obj.target, row_obj.baseline);
```

---

## 📝 شرح:

```javascript
// عند إنشاء مؤشر L2:
var l2Item = {
  code: '1.1',
  name: 'مؤشر 1.1',
  achieved: '85%',
  target: '88%',
  baseline: '86%',
  // أضف هذا السطر:
  completion: calcComp('85%', '88%', '86%')  // = 97
};

l2.push(l2Item);
```

---

## 🔍 البحث عن الموقع:

في الملف، ابحث عن:
1. `function parseRowsFull`
2. ابحث عن حيث يتم إنشاء objects مع `code`, `achieved`, `target`, `baseline`
3. أضف الحساب **قبل** `l2.push(...)` مباشرة

---

## 🎯 النتيجة:

```
قبل:  البيانات بدون completion
بعد:  كل مؤشر يحسب completion صحيح تلقائياً
```

---

هل تستطيع **إيجاد السطر حيث يتم عمل `l2.push(...)`** في `parseRowsFull()`؟

أخبرني بـ:
- رقم السطر تقريباً
- أو نصّ من 3-5 سطور حول `l2.push`

